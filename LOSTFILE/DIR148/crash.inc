#include <a_samp>
new logstring[256];
#if defined crash
	#endinput
#endif
#define crash

stock writelog(text[])
{
	if(!fexist("log.txt"))fclose(fopen("log.txt",io_write));
	new File:handler = fopen("log.txt",io_append);
	new string_[256];
	format(string_,256,"%s\r\n",text);
	fwrite(handler,string_);
	fclose(handler);
}
stock c_heapspace(){  writelog("heapspace();");return heapspace(); }
stock c_funcidx( name[]){  writelog("funcidx( name);");return funcidx( name); }
stock c_numargs(){  writelog("numargs();");return numargs(); }
stock c_getarg(arg, index){  writelog("getarg(arg, index);");return getarg(arg, index); }
stock c_setarg(arg, index, value){  writelog("setarg(arg, index, value);");return setarg(arg, index, value); }
stock c_tolower(c){  writelog("tolower(c);");return tolower(c); }
stock c_toupper(c){  writelog("toupper(c);");return toupper(c); }
stock c_swapchars(c){  writelog("swapchars(c);");return swapchars(c); }
stock c_random(max){  writelog("random(max);");return random(max); }
stock c_min(value1, value2){  writelog("min(value1, value2);");return min(value1, value2); }
stock c_max(value1, value2){  writelog("max(value1, value2);");return max(value1, value2); }
stock c_clamp(value, min, max){  writelog("clamp(value, min, max);");return clamp(value, min, max); }
stock c_sendstring( message[], destination[]){  writelog("sendstring( message,  destination);");return sendstring( message,  destination); }
stock c_sendpacket( packet[], size, destination[]){  writelog("sendpacket( packet, size,  destination);");return sendpacket( packet, size,  destination); }
stock c_listenport(port){  writelog("listenport(port);");return listenport(port); }
stock File:c_fopen( name[], filemode:mode ){  writelog("fopen( name, filemode: mode );");return fopen( name, filemode:mode ); }
stock bool:c_fclose(File: handle){  writelog("fclose( handle);");return fclose( handle); }
stock File:c_ftemp(){  writelog("ftemp();");return ftemp(); }
stock bool:c_fremove( name[]){  writelog("fremove( name);");return fremove( name); }
stock c_fwrite(File: handle, string[]){  writelog("fwrite( handle,  string);");return fwrite( handle,  string); }
stock c_fread(File: handle, string[], size , bool:pack ){  writelog("fread( handle, string, size ,  pack );");return fread( handle, string, size , bool:pack ); }
stock bool:c_fputchar(File: handle, value, bool: utf8 ){  writelog("fputchar( handle, value,  utf8 );");return fputchar( handle, value,  utf8 ); }
stock c_fgetchar(File: handle, value, bool: utf8 ){  writelog("fgetchar( handle, value,  utf8 );");return fgetchar( handle, value,  utf8 ); }
stock c_fblockwrite(File: handle, buffer[], size ){  writelog("fblockwrite( handle,  buffer, size );");return fblockwrite( handle,  buffer, size ); }
stock c_fblockread(File: handle, buffer[], size ){  writelog("fblockread( handle, buffer, size );");return fblockread( handle, buffer, size ); }
stock c_fseek(File: handle, position , seek_whence: whence ){  writelog("fseek( handle, position , seek_whence: whence );");return fseek( handle, position , seek_whence: whence ); }
stock c_flength(File: handle){  writelog("flength( handle);");return flength( handle); }
stock c_fexist( pattern[]){  writelog("fexist( pattern);");return fexist( pattern); }
stock bool:c_fmatch(name[], pattern[], index , size ){  writelog("fmatch(name,  pattern, index , size );");return fmatch(name,  pattern, index , size ); }
stock Float:c_float(value){  writelog("float(value);");return float(value); }
stock Float:c_floatstr( string[]){  writelog("floatstr( string);");return floatstr( string); }
stock Float:c_floatmul(Float:oper1, Float:oper2){  writelog("floatmul(oper1, oper2);");return floatmul(oper1, oper2); }
stock Float:c_floatdiv(Float:dividend, Float:divisor){  writelog("floatdiv(dividend, divisor);");return floatdiv(dividend, divisor); }
stock Float:c_floatadd(Float:oper1, Float:oper2){  writelog("floatadd(oper1, oper2);");return floatadd(oper1, oper2); }
stock Float:c_floatsub(Float:oper1, Float:oper2){  writelog("floatsub(oper1, oper2);");return floatsub(oper1, oper2); }
stock Float:c_floatfract(Float:value){  writelog("floatfract(value);");return floatfract(value); }
stock c_floatround(Float:value, floatround_method:method){  writelog("floatround(value, floatround_method:method);");return floatround(value, floatround_method:method); }
stock c_floatcmp(Float:oper1, Float:oper2){  writelog("floatcmp(oper1, oper2);");return floatcmp(oper1, oper2); }
stock Float:c_floatsqroot(Float:value){  writelog("floatsqroot(value);");return floatsqroot(value); }
stock Float:c_floatpower(Float:value, Float:exponent){  writelog("floatpower(value, exponent);");return floatpower(value, exponent); }
stock Float:c_floatlog(Float:value, Float:base){  writelog("floatlog(value, base);");return floatlog(value, base); }
stock Float:c_floatsin(Float:value, anglemode:mode){  writelog("floatsin(value, anglemode:mode);");return floatsin(value, anglemode:mode); }
stock Float:c_floatcos(Float:value, anglemode:mode){  writelog("floatcos(value, anglemode:mode);");return floatcos(value, anglemode:mode); }
stock Float:c_floattan(Float:value, anglemode:mode){  writelog("floattan(value, anglemode:mode);");return floattan(value, anglemode:mode); }
stock c_strlen( string[]){  writelog("strlen( string);");return strlen( string); }
stock c_strpack(dest[], source[], maxlength){  writelog("strpack(dest,  source, maxlength);");return strpack(dest,  source, maxlength); }
stock c_strunpack(dest[], source[], maxlength){  writelog("strunpack(dest,  source, maxlength);");return strunpack(dest,  source, maxlength); }
stock c_strcat(dest[], source[], maxlength){  writelog("strcat(dest,  source, maxlength);");return strcat(dest,  source, maxlength); }
stock c_strmid(dest[], source[], start, end, maxlength){  writelog("strmid(dest,  source, start, end, maxlength);");return strmid(dest,  source, start, end, maxlength); }
stock bool:c_strins(string[], substr[], pos, maxlength){  writelog(" strins(string,  substr, pos, maxlength);");return  strins(string,  substr, pos, maxlength); }
stock bool:c_strdel(string[], start, end){  writelog(" strdel(string, start, end);");return  strdel(string, start, end); }
stock c_strcmp( string1[], string2[], bool:ignorecase){  writelog("strcmp( string1,  string2, ignorecase);");return strcmp( string1,  string2, ignorecase); }
stock c_strfind( string[], sub[], bool:ignorecase, pos){  writelog("strfind( string,  sub, ignorecase, pos);");return strfind( string,  sub, ignorecase, pos); }
stock c_strval( string[]){  writelog("strval( string);");return strval( string); }
stock c_valstr(dest[], value, bool:pack){  writelog("valstr(dest, value, pack);");return valstr(dest, value, pack); }
stock bool:c_ispacked( string[]){  writelog(" ispacked( string);");return  ispacked( string); }
stock c_uudecode(dest[], source[], maxlength){  writelog("uudecode(dest,  source, maxlength);");return uudecode(dest,  source, maxlength); }
stock c_uuencode(dest[], source[], numbytes, maxlength){  writelog("uuencode(dest,  source, numbytes, maxlength);");return uuencode(dest,  source, numbytes, maxlength); }
stock c_memcpy(dest[], source[], index, numbytes, maxlength){  writelog("memcpy(dest,  source, index, numbytes, maxlength);");return memcpy(dest,  source, index, numbytes, maxlength); }
stock c_gettime(&hour, &minute, &second){  writelog("gettime(hour, minute, second);");return gettime(hour, minute, second); }
stock c_getdate(&year, &month, &day){  writelog("getdate(year, month, day);");return getdate(year, month, day); }
stock c_tickcount(&granularity){  writelog("tickcount(granularity);");return tickcount(granularity); }
stock c_DestroyVehicle(vehicleid){  writelog("DestroyVehicle(vehicleid);");return DestroyVehicle(vehicleid); }
stock c_GetVehiclePos(vehicleid, &Float:x, &Float:y, &Float:z){  writelog("GetVehiclePos(vehicleid, x, y, z);");return GetVehiclePos(vehicleid, x, y, z); }
stock c_SetVehiclePos(vehicleid, Float:x, Float:y, Float:z){  writelog("SetVehiclePos(vehicleid, x, y, z);");return SetVehiclePos(vehicleid, x, y, z); }
stock c_GetVehicleZAngle(vehicleid, &Float:z_angle){  writelog("GetVehicleZAngle(vehicleid, z_angle);");return GetVehicleZAngle(vehicleid, z_angle); }
stock c_SetVehicleZAngle(vehicleid, Float:z_angle){  writelog("SetVehicleZAngle(vehicleid, z_angle);");return SetVehicleZAngle(vehicleid, z_angle); }
stock c_SetVehicleParamsForPlayer(vehicleid,playerid,objective,doorslocked){  writelog("SetVehicleParamsForPlayer(vehicleid,playerid,objective,doorslocked);");return SetVehicleParamsForPlayer(vehicleid,playerid,objective,doorslocked); }
stock c_SetVehicleToRespawn(vehicleid){  writelog("SetVehicleToRespawn(vehicleid);");return SetVehicleToRespawn(vehicleid); }
stock c_LinkVehicleToInterior(vehicleid, interiorid){  writelog("LinkVehicleToInterior(vehicleid, interiorid);");return LinkVehicleToInterior(vehicleid, interiorid); }
stock c_AddVehicleComponent(vehicleid, componentid){  writelog("AddVehicleComponent(vehicleid, componentid);");return AddVehicleComponent(vehicleid, componentid); }
stock c_RemoveVehicleComponent(vehicleid, componentid){  writelog("RemoveVehicleComponent(vehicleid, componentid);");return RemoveVehicleComponent(vehicleid, componentid); }
stock c_ChangeVehicleColor(vehicleid, color1, color2){  writelog("ChangeVehicleColor(vehicleid, color1, color2);");return ChangeVehicleColor(vehicleid, color1, color2); }
stock c_ChangeVehiclePaintjob(vehicleid, paintjobid){  writelog("ChangeVehiclePaintjob(vehicleid, paintjobid);");return ChangeVehiclePaintjob(vehicleid, paintjobid); }
stock c_SetVehicleHealth(vehicleid, Float:health){  writelog("SetVehicleHealth(vehicleid, health);");return SetVehicleHealth(vehicleid, health); }
stock c_GetVehicleHealth(vehicleid, &Float:health){  writelog("GetVehicleHealth(vehicleid, health);");return GetVehicleHealth(vehicleid, health); }
stock c_AttachTrailerToVehicle(trailerid, vehicleid){  writelog("AttachTrailerToVehicle(trailerid, vehicleid);");return AttachTrailerToVehicle(trailerid, vehicleid); }
stock c_DetachTrailerFromVehicle(vehicleid){  writelog("DetachTrailerFromVehicle(vehicleid);");return DetachTrailerFromVehicle(vehicleid); }
stock c_IsTrailerAttachedToVehicle(vehicleid){  writelog("IsTrailerAttachedToVehicle(vehicleid);");return IsTrailerAttachedToVehicle(vehicleid); }
stock c_GetVehicleTrailer(vehicleid){  writelog("GetVehicleTrailer(vehicleid);");return GetVehicleTrailer(vehicleid); }
stock c_SetVehicleNumberPlate(vehicleid, numberplate[]){  writelog("SetVehicleNumberPlate(vehicleid, numberplate);");return SetVehicleNumberPlate(vehicleid, numberplate); }
stock c_GetVehicleModel(vehicleid){  writelog("GetVehicleModel(vehicleid);");return GetVehicleModel(vehicleid); }
stock c_SetVehicleVirtualWorld(vehicleid, worldid){  writelog("SetVehicleVirtualWorld(vehicleid, worldid);");return SetVehicleVirtualWorld(vehicleid, worldid); }
stock c_GetVehicleVirtualWorld(vehicleid){  writelog("GetVehicleVirtualWorld(vehicleid);");return GetVehicleVirtualWorld(vehicleid); }
stock c_CreateObject(modelid, Float:X, Float:Y, Float:Z, Float:rX, Float:rY, Float:rZ){  writelog("CreateObject(modelid, X, Y, Z, rX, rY, rZ);");return CreateObject(modelid, X, Y, Z, rX, rY, rZ); }
stock c_SetObjectPos(objectid, Float:X, Float:Y, Float:Z){  writelog("SetObjectPos(objectid, X, Y, Z);");return SetObjectPos(objectid, X, Y, Z); }
stock c_GetObjectPos(objectid, &Float:X, &Float:Y, &Float:Z){  writelog("GetObjectPos(objectid, X, Y, Z);");return GetObjectPos(objectid, X, Y, Z); }
stock c_SetObjectRot(objectid, Float:RotX, Float:RotY, Float:RotZ){  writelog("SetObjectRot(objectid, RotX, RotY, RotZ);");return SetObjectRot(objectid, RotX, RotY, RotZ); }
stock c_GetObjectRot(objectid, &Float:RotX, &Float:RotY, &Float:RotZ){  writelog("GetObjectRot(objectid, RotX, RotY, RotZ);");return GetObjectRot(objectid, RotX, RotY, RotZ); }
stock c_IsValidObject(objectid){  writelog("IsValidObject(objectid);");return IsValidObject(objectid); }
stock c_DestroyObject(objectid){  writelog("DestroyObject(objectid);");return DestroyObject(objectid); }
stock c_MoveObject(objectid, Float:X, Float:Y, Float:Z, Float:Speed){  writelog("MoveObject(objectid, X, Y, Z, Speed);");return MoveObject(objectid, X, Y, Z, Speed); }
stock c_StopObject(objectid){  writelog("StopObject(objectid);");return StopObject(objectid); }
stock c_CreatePlayerObject(playerid, modelid, Float:X, Float:Y, Float:Z, Float:rX, Float:rY, Float:rZ){  writelog("CreatePlayerObject(playerid, modelid, X, Y, Z, rX, rY, rZ);");return CreatePlayerObject(playerid, modelid, X, Y, Z, rX, rY, rZ); }
stock c_SetPlayerObjectPos(playerid, objectid, Float:X, Float:Y, Float:Z){  writelog("SetPlayerObjectPos(playerid, objectid, X, Y, Z);");return SetPlayerObjectPos(playerid, objectid, X, Y, Z); }
stock c_GetPlayerObjectPos(playerid, objectid, &Float:X, &Float:Y, &Float:Z){  writelog("GetPlayerObjectPos(playerid, objectid, X, Y, Z);");return GetPlayerObjectPos(playerid, objectid, X, Y, Z); }
stock c_SetPlayerObjectRot(playerid, objectid, Float:RotX, Float:RotY, Float:RotZ){  writelog("SetPlayerObjectRot(playerid, objectid, RotX, RotY, RotZ);");return SetPlayerObjectRot(playerid, objectid, RotX, RotY, RotZ); }
stock c_GetPlayerObjectRot(playerid, objectid, &Float:RotX, &Float:RotY, &Float:RotZ){  writelog("GetPlayerObjectRot(playerid, objectid, RotX, RotY, RotZ);");return GetPlayerObjectRot(playerid, objectid, RotX, RotY, RotZ); }
stock c_IsValidPlayerObject(playerid, objectid){  writelog("IsValidPlayerObject(playerid, objectid);");return IsValidPlayerObject(playerid, objectid); }
stock c_DestroyPlayerObject(playerid, objectid){  writelog("DestroyPlayerObject(playerid, objectid);");return DestroyPlayerObject(playerid, objectid); }
stock c_MovePlayerObject(playerid, objectid, Float:X, Float:Y, Float:Z, Float:Speed){  writelog("MovePlayerObject(playerid, objectid, X, Y, Z, Speed);");return MovePlayerObject(playerid, objectid, X, Y, Z, Speed); }
stock c_SpawnPlayer(playerid){  writelog("SpawnPlayer(playerid);");return SpawnPlayer(playerid); }
stock c_SetPlayerPos(playerid, Float:x, Float:y, Float:z){  writelog("SetPlayerPos(playerid, x, y, z);");return SetPlayerPos(playerid, x, y, z); }
stock c_SetPlayerPosFindZ(playerid, Float:x, Float:y, Float:z){  writelog("SetPlayerPosFindZ(playerid, x, y, z);");return SetPlayerPosFindZ(playerid, x, y, z); }
stock c_GetPlayerPos(playerid, &Float:x, &Float:y, &Float:z){  writelog("GetPlayerPos(playerid, x, y, z);");return GetPlayerPos(playerid, x, y, z); }
stock c_SetPlayerFacingAngle(playerid,Float:ang){  writelog("SetPlayerFacingAngle(playerid,ang);");return SetPlayerFacingAngle(playerid,ang); }
stock c_GetPlayerFacingAngle(playerid,&Float:ang){  writelog("GetPlayerFacingAngle(playerid,ang);");return GetPlayerFacingAngle(playerid,ang); }
stock c_SetPlayerInterior(playerid,interiorid){  writelog("SetPlayerInterior(playerid,interiorid);");return SetPlayerInterior(playerid,interiorid); }
stock c_GetPlayerInterior(playerid){  writelog("GetPlayerInterior(playerid);");return GetPlayerInterior(playerid); }
stock c_SetPlayerHealth(playerid, Float:health){  writelog("SetPlayerHealth(playerid, health);");return SetPlayerHealth(playerid, health); }
stock c_GetPlayerHealth(playerid, &Float:health){  writelog("GetPlayerHealth(playerid, health);");return GetPlayerHealth(playerid, health); }
stock c_SetPlayerArmour(playerid, Float:armour){  writelog("SetPlayerArmour(playerid, armour);");return SetPlayerArmour(playerid, armour); }
stock c_GetPlayerArmour(playerid, &Float:armour){  writelog("GetPlayerArmour(playerid, armour);");return GetPlayerArmour(playerid, armour); }
stock c_SetPlayerAmmo(playerid, weaponslot, ammo){  writelog("SetPlayerAmmo(playerid, weaponslot, ammo);");return SetPlayerAmmo(playerid, weaponslot, ammo); }
stock c_GetPlayerAmmo(playerid){  writelog("GetPlayerAmmo(playerid);");return GetPlayerAmmo(playerid); }
stock c_SetPlayerTeam(playerid, teamid){  writelog("SetPlayerTeam(playerid, teamid);");return SetPlayerTeam(playerid, teamid); }
stock c_GetPlayerTeam(playerid){  writelog("GetPlayerTeam(playerid);");return GetPlayerTeam(playerid); }
stock c_SetPlayerScore(playerid,score){  writelog("SetPlayerScore(playerid,score);");return SetPlayerScore(playerid,score); }
stock c_GetPlayerScore(playerid){  writelog("GetPlayerScore(playerid);");return GetPlayerScore(playerid); }
stock c_SetPlayerColor(playerid,color){  writelog("SetPlayerColor(playerid,color);");return SetPlayerColor(playerid,color); }
stock c_GetPlayerColor(playerid){  writelog("GetPlayerColor(playerid);");return GetPlayerColor(playerid); }
stock c_SetPlayerSkin(playerid, skinid){  writelog("SetPlayerSkin(playerid, skinid);");return SetPlayerSkin(playerid, skinid); }
stock c_GetPlayerSkin(playerid){  writelog("GetPlayerSkin(playerid);");return GetPlayerSkin(playerid); }
stock c_GivePlayerWeapon(playerid, weaponid, ammo){  writelog("GivePlayerWeapon(playerid, weaponid, ammo);");return GivePlayerWeapon(playerid, weaponid, ammo); }
stock c_ResetPlayerWeapons(playerid){  writelog("ResetPlayerWeapons(playerid);");return ResetPlayerWeapons(playerid); }
stock c_GetPlayerWeaponData(playerid, slot, &weapons, &ammo){  writelog("GetPlayerWeaponData(playerid, slot, weapons, ammo);");return GetPlayerWeaponData(playerid, slot, weapons, ammo); }
stock c_GivePlayerMoney(playerid,money){  writelog("GivePlayerMoney(playerid,money);");return GivePlayerMoney(playerid,money); }
stock c_ResetPlayerMoney(playerid){  writelog("ResetPlayerMoney(playerid);");return ResetPlayerMoney(playerid); }
stock c_SetPlayerName(playerid, name[]){  writelog("SetPlayerName(playerid,  name);");return SetPlayerName(playerid,  name); }
stock c_GetPlayerMoney(playerid){  writelog("GetPlayerMoney(playerid);");return GetPlayerMoney(playerid); }
stock c_GetPlayerState(playerid){  writelog("GetPlayerState(playerid);");return GetPlayerState(playerid); }
stock c_GetPlayerIp(playerid, name[], len){  writelog("GetPlayerIp(playerid, name, len);");return GetPlayerIp(playerid, name, len); }
stock c_GetPlayerPing(playerid){  writelog("GetPlayerPing(playerid);");return GetPlayerPing(playerid); }
stock c_GetPlayerWeapon(playerid){  writelog("GetPlayerWeapon(playerid);");return GetPlayerWeapon(playerid); }
stock c_GetPlayerKeys(playerid, &keyss, &updown, &leftright){  writelog("GetPlayerKeys(playerid, keyss, updown, leftright);");return GetPlayerKeys(playerid, keyss, updown, leftright); }
stock c_GetPlayerName(playerid, name[], len){  writelog("GetPlayerName(playerid,  name, len);");return GetPlayerName(playerid,  name, len); }
stock c_SetPlayerTime(playerid, hour, minute){  writelog("SetPlayerTime(playerid, hour, minute);");return SetPlayerTime(playerid, hour, minute); }
stock c_GetPlayerTime(playerid, &hour, &minute){  writelog("GetPlayerTime(playerid, hour, minute);");return GetPlayerTime(playerid, hour, minute); }
stock c_TogglePlayerClock(playerid, toggle){  writelog("TogglePlayerClock(playerid, toggle);");return TogglePlayerClock(playerid, toggle); }
stock c_SetPlayerWeather(playerid, weather){  writelog("SetPlayerWeather(playerid, weather);");return SetPlayerWeather(playerid, weather); }
stock c_ForceClassSelection(playerid){  writelog("ForceClassSelection(playerid);");return ForceClassSelection(playerid); }
stock c_SetPlayerWantedLevel(playerid, level){  writelog("SetPlayerWantedLevel(playerid, level);");return SetPlayerWantedLevel(playerid, level); }
stock c_GetPlayerWantedLevel(playerid){  writelog("GetPlayerWantedLevel(playerid);");return GetPlayerWantedLevel(playerid); }
stock c_PutPlayerInVehicle(playerid, vehicleid, seatid){  writelog("PutPlayerInVehicle(playerid, vehicleid, seatid);");return PutPlayerInVehicle(playerid, vehicleid, seatid); }
stock c_GetPlayerVehicleID(playerid){  writelog("GetPlayerVehicleID(playerid);");return GetPlayerVehicleID(playerid); }
stock c_RemovePlayerFromVehicle(playerid){  writelog("RemovePlayerFromVehicle(playerid);");return RemovePlayerFromVehicle(playerid); }
stock c_TogglePlayerControllable(playerid, toggle){  writelog("TogglePlayerControllable(playerid, toggle);");return TogglePlayerControllable(playerid, toggle); }
stock c_PlayerPlaySound(playerid, soundid, Float:x, Float:y, Float:z){  writelog("PlayerPlaySound(playerid, soundid, x, y, z);");return PlayerPlaySound(playerid, soundid, x, y, z); }
stock c_ClearAnimations(playerid){  writelog("ClearAnimations(playerid);");return ClearAnimations(playerid); }
stock c_GetPlayerSpecialAction(playerid){  writelog("GetPlayerSpecialAction(playerid);");return GetPlayerSpecialAction(playerid); }
stock c_SetPlayerSpecialAction(playerid,actionid){  writelog("SetPlayerSpecialAction(playerid,actionid);");return SetPlayerSpecialAction(playerid,actionid); }
stock c_SetPlayerCheckpoint(playerid, Float:x, Float:y, Float:z, Float:size){  writelog("SetPlayerCheckpoint(playerid, x, y, z, size);");return SetPlayerCheckpoint(playerid, x, y, z, size); }
stock c_DisablePlayerCheckpoint(playerid){  writelog("DisablePlayerCheckpoint(playerid);");return DisablePlayerCheckpoint(playerid); }
stock c_DisablePlayerRaceCheckpoint(playerid){  writelog("DisablePlayerRaceCheckpoint(playerid);");return DisablePlayerRaceCheckpoint(playerid); }
stock c_SetPlayerWorldBounds(playerid,Float:x_max,Float:x_min,Float:y_max,Float:y_min){  writelog("SetPlayerWorldBounds(playerid,x_max,x_min,y_max,y_min);");return SetPlayerWorldBounds(playerid,x_max,x_min,y_max,y_min); }
stock c_SetPlayerMarkerForPlayer(playerid, showplayerid, color){  writelog("SetPlayerMarkerForPlayer(playerid, showplayerid, color);");return SetPlayerMarkerForPlayer(playerid, showplayerid, color); }
stock c_ShowPlayerNameTagForPlayer(playerid, showplayerid, show){  writelog("ShowPlayerNameTagForPlayer(playerid, showplayerid, show);");return ShowPlayerNameTagForPlayer(playerid, showplayerid, show); }
stock c_SetPlayerMapIcon(playerid, iconid, Float:x, Float:y, Float:z, markertype, color){  writelog("SetPlayerMapIcon(playerid, iconid, x, y, z, markertype, color);");return SetPlayerMapIcon(playerid, iconid, x, y, z, markertype, color); }
stock c_RemovePlayerMapIcon(playerid, iconid){  writelog("RemovePlayerMapIcon(playerid, iconid);");return RemovePlayerMapIcon(playerid, iconid); }
stock c_SetPlayerCameraPos(playerid,Float:x, Float:y, Float:z){  writelog("SetPlayerCameraPos(playerid,x, y, z);");return SetPlayerCameraPos(playerid,x, y, z); }
stock c_SetPlayerCameraLookAt(playerid, Float:x, Float:y, Float:z){  writelog("SetPlayerCameraLookAt(playerid, x, y, z);");return SetPlayerCameraLookAt(playerid, x, y, z); }
stock c_SetCameraBehindPlayer(playerid){  writelog("SetCameraBehindPlayer(playerid);");return SetCameraBehindPlayer(playerid); }
stock c_AllowPlayerTeleport(playerid, allow){  writelog("AllowPlayerTeleport(playerid, allow);");return AllowPlayerTeleport(playerid, allow); }
stock c_IsPlayerConnected(playerid){  writelog("IsPlayerConnected(playerid);");return IsPlayerConnected(playerid); }
stock c_IsPlayerInVehicle(playerid, vehicleid){  writelog("IsPlayerInVehicle(playerid, vehicleid);");return IsPlayerInVehicle(playerid, vehicleid); }
stock c_IsPlayerInAnyVehicle(playerid){  writelog("IsPlayerInAnyVehicle(playerid);");return IsPlayerInAnyVehicle(playerid); }
stock c_IsPlayerInCheckpoint(playerid){  writelog("IsPlayerInCheckpoint(playerid);");return IsPlayerInCheckpoint(playerid); }
stock c_IsPlayerInRaceCheckpoint(playerid){  writelog("IsPlayerInRaceCheckpoint(playerid);");return IsPlayerInRaceCheckpoint(playerid); }
stock c_SetPlayerVirtualWorld(playerid, worldid){  writelog("SetPlayerVirtualWorld(playerid, worldid);");return SetPlayerVirtualWorld(playerid, worldid); }
stock c_GetPlayerVirtualWorld(playerid){  writelog("GetPlayerVirtualWorld(playerid);");return GetPlayerVirtualWorld(playerid); }
stock c_EnableStuntBonusForPlayer(playerid, enable){  writelog("EnableStuntBonusForPlayer(playerid, enable);");return EnableStuntBonusForPlayer(playerid, enable); }
stock c_EnableStuntBonusForAll(enable){  writelog("EnableStuntBonusForAll(enable);");return EnableStuntBonusForAll(enable); }
stock c_TogglePlayerSpectating(playerid, toggle){  writelog("TogglePlayerSpectating(playerid, toggle);");return TogglePlayerSpectating(playerid, toggle); }
stock c_PlayerSpectatePlayer(playerid, targetplayerid, mode ){  writelog("PlayerSpectatePlayer(playerid, targetplayerid, mode );");return PlayerSpectatePlayer(playerid, targetplayerid, mode ); }
stock c_PlayerSpectateVehicle(playerid, targetvehicleid, mode ){  writelog("PlayerSpectateVehicle(playerid, targetvehicleid, mode );");return PlayerSpectateVehicle(playerid, targetvehicleid, mode ); }
stock c_print( string[]){  format(logstring, sizeof(logstring),"print(%s);", string);writelog(logstring);return print( string); }
stock c_SendClientMessage(playerid, color, message[]){  writelog("SendClientMessage(playerid, color,  message);");return SendClientMessage(playerid, color,  message); }
stock c_SendClientMessageToAll(color, message[]){  writelog("SendClientMessageToAll(color,  message);");return SendClientMessageToAll(color,  message); }
stock c_SendPlayerMessageToPlayer(playerid, senderid, message[]){  writelog("SendPlayerMessageToPlayer(playerid, senderid,  message);");return SendPlayerMessageToPlayer(playerid, senderid,  message); }
stock c_SendPlayerMessageToAll(senderid, message[]){  writelog("SendPlayerMessageToAll(senderid,  message);");return SendPlayerMessageToAll(senderid,  message); }
stock c_SendDeathMessage(killer,killee,weapon){  writelog("SendDeathMessage(killer,killee,weapon);");return SendDeathMessage(killer,killee,weapon); }
stock c_GameTextForAll( string[],time,style){  writelog("GameTextForAll( string,time,style);");return GameTextForAll( string,time,style); }
stock c_GameTextForPlayer(playerid,string[],time,style){  writelog("GameTextForPlayer(playerid, string,time,style);");return GameTextForPlayer(playerid, string,time,style); }
stock c_SetTimer(funcname[], interval, repeating){  format(logstring, sizeof(logstring),"Settimer(%s,%d,%d);", funcname, interval, repeating);writelog(logstring);return SetTimer(funcname, interval, repeating); }
stock c_KillTimer(timerid){  writelog("KillTimer(timerid);");return KillTimer(timerid); }
stock c_GetTickCount(){  writelog("GetTickCount();");return GetTickCount(); }
stock c_GetMaxPlayers(){  writelog("GetMaxPlayers();");return GetMaxPlayers(); }
stock c_LimitGlobalChatRadius(Float:chat_radius){  writelog("LimitGlobalChatRadius(chat_radius);");return LimitGlobalChatRadius(chat_radius); }
stock Float:c_asin(Float:value){  writelog("asin(value);");return asin(value); }
stock Float:c_acos(Float:value){  writelog("acos(value);");return acos(value); }
stock Float:c_atan(Float:value){  writelog("atan(value);");return atan(value); }
stock Float:c_atan2(Float:x, Float:y){  writelog("atan2(x, y);");return atan2(x, y); }
stock c_SetGameModeText( string[]){  format(logstring, sizeof(logstring),"SetGameModeText(%s);", string);writelog(logstring);return SetGameModeText( string); }
stock c_SetTeamCount(count){  writelog("SetTeamCount(count);");return SetTeamCount(count); }
stock c_CreatePickup(model, type, Float:X, Float:Y, Float:Z){  writelog("CreatePickup(model, type, X, Y, Z);");return CreatePickup(model, type, X, Y, Z); }
stock c_DestroyPickup(pickup){  writelog("DestroyPickup(pickup);");return DestroyPickup(pickup); }
stock c_ShowNameTags(show){  writelog("ShowNameTags(show);");return ShowNameTags(show); }
stock c_ShowPlayerMarkers(show){  writelog("ShowPlayerMarkers(show);");return ShowPlayerMarkers(show); }
stock c_GameModeExit(){  writelog("GameModeExit();");return GameModeExit(); }
stock c_SetWorldTime(hour){  writelog("SetWorldTime(hour);");return SetWorldTime(hour); }
stock c_GetWeaponName(weaponid, weapon[], len){  writelog("GetWeaponName(weaponid,  weapon, len);");return GetWeaponName(weaponid,  weapon, len); }
stock c_EnableTirePopping(enable){  writelog("EnableTirePopping(enable);");return EnableTirePopping(enable); }
stock c_AllowInteriorWeapons(allow){  writelog("AllowInteriorWeapons(allow);");return AllowInteriorWeapons(allow); }
stock c_SetWeather(weatherid){  writelog("SetWeather(weatherid);");return SetWeather(weatherid); }
stock c_SetGravity(Float:gravity){  writelog("SetGravity(gravity);");return SetGravity(gravity); }
stock c_AllowAdminTeleport(allow){  writelog("AllowAdminTeleport(allow);");return AllowAdminTeleport(allow); }
stock c_SetDeathDropAmount(amount){  writelog("SetDeathDropAmount(amount);");return SetDeathDropAmount(amount); }
stock c_CreateExplosion(Float:X, Float:Y, Float:Z, type, Float:Radius){  writelog("CreateExplosion(X, Y, Z, type, Radius);");return CreateExplosion(X, Y, Z, type, Radius); }
stock c_EnableZoneNames(enable){  writelog("EnableZoneNames(enable);");return EnableZoneNames(enable); }
stock c_UsePlayerPedAnims()	{ 		 writelog("UsePlayerPedAnims();		");return UsePlayerPedAnims(); }
stock c_DisableInteriorEnterExits() {    writelog("DisableInteriorEnterExits();  ");return DisableInteriorEnterExits(); }
stock c_SetNameTagDrawDistance(Float:distance){   writelog("SetNameTagDrawDistance(distance); ");return SetNameTagDrawDistance(distance); }
stock c_IsPlayerAdmin(playerid){  writelog("IsPlayerAdmin(playerid);");return IsPlayerAdmin(playerid); }
stock c_Kick(playerid){  writelog("Kick(playerid);");return Kick(playerid); }
stock c_Ban(playerid){  writelog("Ban(playerid);");return Ban(playerid); }
stock c_BanEx(playerid, reason[]){  writelog("BanEx(playerid,  reason);");return BanEx(playerid,  reason); }
stock c_SendRconCommand(command[]){  writelog("SendRconCommand(command);");return SendRconCommand(command); }
stock c_GetServerVarAsString( varname[], buffer[], len){  writelog("GetServerVarAsString( varname, buffer, len);");return GetServerVarAsString( varname, buffer, len); }
stock c_GetServerVarAsInt( varname[]){  writelog("GetServerVarAsInt( varname);");return GetServerVarAsInt( varname); }
stock c_GetServerVarAsBool( varname[]){  writelog("GetServerVarAsBool( varname);");return GetServerVarAsBool( varname); }
stock Menu:c_CreateMenu( title[], columns, Float:x, Float:y, Float:col1width, Float:col2width){  writelog("CreateMenu( title, columns, x, y, col1width, col2width );");return CreateMenu( title, columns, x, y, col1width, col2width ); }
stock c_DestroyMenu(Menu:menuid){  writelog("DestroyMenu(menuid);");return DestroyMenu(menuid); }
stock c_AddMenuItem(Menu:menuid, column, menutext[]){  writelog("AddMenuItem(menuid, column,  menutext);");return AddMenuItem(menuid, column,  menutext); }
stock c_SetMenuColumnHeader(Menu:menuid, column, columnheader[]){  writelog("SetMenuColumnHeader(menuid, column,  columnheader);");return SetMenuColumnHeader(menuid, column,  columnheader); }
stock c_ShowMenuForPlayer(Menu:menuid, playerid){  writelog("ShowMenuForPlayer(menuid, playerid);");return ShowMenuForPlayer(menuid, playerid); }
stock c_HideMenuForPlayer(Menu:menuid, playerid){  writelog("HideMenuForPlayer(menuid, playerid);");return HideMenuForPlayer(menuid, playerid); }
stock c_IsValidMenu(Menu:menuid){  writelog("IsValidMenu(menuid);");return IsValidMenu(menuid); }
stock c_DisableMenu(Menu:menuid){  writelog("DisableMenu(menuid);");return DisableMenu(menuid); }
stock c_DisableMenuRow(Menu:menuid, row){  writelog("DisableMenuRow(menuid, row);");return DisableMenuRow(menuid, row); }
stock Menu:c_GetPlayerMenu(playerid){  writelog("GetPlayerMenu(playerid);");return GetPlayerMenu(playerid); }
stock Text:c_TextDrawCreate(Float:x, Float:y, text[]){  format(logstring, sizeof(logstring),"TextDrawCreate(%f,%f,%s);", x, y, text);writelog(logstring);return TextDrawCreate(x, y, text); }
stock c_TextDrawDestroy(Text:text){  format(logstring, sizeof(logstring),"TextDrawDestroy(%s);", "text");writelog(logstring);return TextDrawDestroy(text); }
stock c_TextDrawLetterSize(Text:text, Float:x, Float:y){  format(logstring, sizeof(logstring),"TextDrawLetterSize(%s,%f,%f);", "text", x, y);writelog(logstring);return TextDrawLetterSize(text, x, y); }
stock c_TextDrawTextSize(Text:text, Float:x, Float:y){  format(logstring, sizeof(logstring),"TextDrawTextSize(%s,%f,%f);", "text", x, y);writelog(logstring);return TextDrawTextSize(text, x, y); }
stock c_TextDrawAlignment(Text:text, alignment){  format(logstring, sizeof(logstring),"TextDrawAlignment(%s,%d);", "text", alignment);writelog(logstring);return TextDrawAlignment(text, alignment); }
stock c_TextDrawColor(Text:text, color){  format(logstring, sizeof(logstring),"TextDrawColor(%s,%d);", "text", color);writelog(logstring);return TextDrawColor(text, color); }
stock c_TextDrawUseBox(Text:text, use){  format(logstring, sizeof(logstring),"TextDrawUseBox(%s,%d);", "text", use);writelog(logstring);return TextDrawUseBox(text, use); }
stock c_TextDrawBoxColor(Text:text, color){  format(logstring, sizeof(logstring),"TextDrawBoxColor(%s,%d);", "text", color);writelog(logstring);return TextDrawBoxColor(text, color); }
stock c_TextDrawSetShadow(Text:text, size){  format(logstring, sizeof(logstring),"TextDrawSetShadow(%s,%d);", "text", size);writelog(logstring);return TextDrawSetShadow(text, size); }
stock c_TextDrawSetOutline(Text:text, size){  format(logstring, sizeof(logstring),"TextDrawSetOutline(%s,%d);", "text", size);writelog(logstring);return TextDrawSetOutline(text, size); }
stock c_TextDrawBackgroundColor(Text:text, color){  format(logstring, sizeof(logstring),"TextDrawBackgroundColor(%s,%d);", "text", color);writelog(logstring);return TextDrawBackgroundColor(text, color); }
stock c_TextDrawFont(Text:text, font){  format(logstring, sizeof(logstring),"TextDrawFont(%s,%d);", "text", font);writelog(logstring);return TextDrawFont(text, font); }
stock c_TextDrawSetProportional(Text:text, set){  format(logstring, sizeof(logstring),"TextDrawSetProportional(%s,%d);", "text", set);writelog(logstring);return TextDrawSetProportional(text, set); }
stock c_TextDrawShowForPlayer(playerid, Text:text){  format(logstring, sizeof(logstring),"TextDrawShowForPlayer(%d,%s);", playerid, "text");writelog(logstring);return TextDrawShowForPlayer(playerid, text); }
stock c_TextDrawHideForPlayer(playerid, Text:text){  format(logstring, sizeof(logstring),"TextDrawHideForPlayer(%d,%s);", playerid, "text");writelog(logstring);return TextDrawHideForPlayer(playerid, text); }
stock c_TextDrawShowForAll(Text:text){  format(logstring, sizeof(logstring),"TextDrawShowForAll(%s);", "text");writelog(logstring);return TextDrawShowForAll(text); }
stock c_TextDrawHideForAll(Text:text){  format(logstring, sizeof(logstring),"TextDrawHideForAll(%s);", "text");writelog(logstring);return TextDrawHideForAll(text); }
stock c_TextDrawSetString(Text:text, string[]){  format(logstring, sizeof(logstring),"TextDrawSetString(%s,%s);", "text", string);writelog(logstring);return TextDrawSetString(text, string); }
stock c_GangZoneCreate(Float:minx, Float:miny, Float:maxx, Float:maxy){  writelog("GangZoneCreate(minx, miny, maxx, maxy);");return GangZoneCreate(minx, miny, maxx, maxy); }
stock c_GangZoneDestroy(zone){  writelog("GangZoneDestroy(zone);");return GangZoneDestroy(zone); }
stock c_GangZoneShowForPlayer(playerid, zone, color){  writelog("GangZoneShowForPlayer(playerid, zone, color);");return GangZoneShowForPlayer(playerid, zone, color); }
stock c_GangZoneShowForAll(zone, color){  writelog("GangZoneShowForAll(zone, color);");return GangZoneShowForAll(zone, color); }
stock c_GangZoneHideForPlayer(playerid, zone){  writelog("GangZoneHideForPlayer(playerid, zone);");return GangZoneHideForPlayer(playerid, zone); }
stock c_GangZoneHideForAll(zone){  writelog("GangZoneHideForAll(zone);");return GangZoneHideForAll(zone); }
stock c_GangZoneFlashForPlayer(playerid, zone, flashcolor){  writelog("GangZoneFlashForPlayer(playerid, zone, flashcolor);");return GangZoneFlashForPlayer(playerid, zone, flashcolor); }
stock c_GangZoneFlashForAll(zone, flashcolor){  writelog("GangZoneFlashForAll(zone, flashcolor);");return GangZoneFlashForAll(zone, flashcolor); }
stock c_GangZoneStopFlashForPlayer(playerid, zone){  writelog("GangZoneStopFlashForPlayer(playerid, zone);");return GangZoneStopFlashForPlayer(playerid, zone); }
stock c_GangZoneStopFlashForAll(zone){  writelog("GangZoneStopFlashForAll(zone);");return GangZoneStopFlashForAll(zone); }
stock c_AddPlayerClass(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, weapon1, weapon1_ammo, weapon2, weapon2_ammo, weapon3, weapon3_ammo)
{
	format(logstring, sizeof(logstring),"AddPlayerClass(%d,%f,%f,%f,%f,%d,%d,%d,%d,%d,%d);", modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, weapon1, weapon1_ammo, weapon2, weapon2_ammo, weapon3, weapon3_ammo);
	writelog(logstring);
	return AddPlayerClass(modelid, spawn_x, spawn_y, spawn_z, z_angle, weapon1, weapon1_ammo, weapon2,  weapon2_ammo, weapon3, weapon3_ammo);
}
stock c_AddPlayerClassEx(teamid, modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, weapon1, weapon1_ammo, weapon2, weapon2_ammo, weapon3, weapon3_ammo)
{
	format(logstring, sizeof(logstring),"AddPlayerClassEx(%d,%f,%f,%f,%f,%d,%d,%d,%d,%d,%d);", teamid, modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, weapon1, weapon1_ammo, weapon2, weapon2_ammo, weapon3, weapon3_ammo);
	writelog(logstring);
	return AddPlayerClassEx(teamid, modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, weapon1, weapon1_ammo, weapon2, weapon2_ammo, weapon3, weapon3_ammo);
}
stock c_AddStaticVehicle(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2)
{
	writelog("AddStaticVehicle(modelid, spawn_x, spawn_y, spawn_z, z_angle, color1, color2);");
	return AddStaticVehicle(modelid, spawn_x, spawn_y, spawn_z, z_angle, color1, color2);
}
stock c_AddStaticVehicleEx(modelid, Float:spawn_x, Float:spawn_y, Float:spawn_z, Float:z_angle, color1, color2, respawn_delay)
{
	writelog("AddStaticVehicleEx(modelid, spawn_x, spawn_y, spawn_z, z_angle, color1, color2, respawn_delay);");
	return AddStaticVehicleEx(modelid, spawn_x, spawn_y, spawn_z, z_angle, color1, color2, respawn_delay);
}
stock c_AddStaticPickup(model,type,Float:X,Float:Y,Float:Z)
{
	writelog("AddStaticPickup(model,type,X,Y,Z);");
	return AddStaticPickup(model,type,X,Y,Z);
}
stock c_StopPlayerObject(playerid, objectid)
{
	writelog("StopPlayerObject(playerid, objectid);");
	return StopPlayerObject(playerid, objectid);
}
stock c_AttachObjectToPlayer(objectid, playerid, Float:OffsetX, Float:OffsetY, Float:OffsetZ, Float:rX, Float:rY, Float:rZ)
{
	writelog("AttachObjectToPlayer(objectid, playerid,OffsetX, OffsetY, OffsetZ, rX, rY, rZ");
	return AttachObjectToPlayer(objectid, playerid, OffsetX, OffsetY, OffsetZ, rX, rY, rZ);
}
stock c_AttachPlayerObjectToPlayer(objectplayer, objectid, attachplayer, Float:OffsetX, Float:OffsetY, Float:OffsetZ, Float:rX, Float:rY, Float:rZ)
{
	writelog("AttachPlayerObjectToPlayer(objectplayer,objectid, attachplayer,OffsetX, OffsetY, OffsetZ, rX, rY, rZ");
	return AttachPlayerObjectToPlayer(objectplayer, objectid, attachplayer, OffsetX, OffsetY, OffsetZ, rX, rY, rZ);
}
stock c_SetSpawnInfo(playerid, team, skin, Float:x, Float:y, Float:z, Float:rotation, weapon1, weapon1_ammo, weapon2, weapon2_ammo, weapon3, weapon3_ammo)
{
	writelog("	SetSpawnInfo(playerid, team, skin, x, y, z, rotation, weapon1, weapon1_ammo, weapon2, weapon2_ammo, weapon3, weapon3_ammo);");
	return SetSpawnInfo(playerid, team, skin, x, y, z, rotation, weapon1, weapon1_ammo, weapon2, weapon2_ammo, weapon3, weapon3_ammo);
}
stock c_CreateVehicle(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay)
{
	writelog("CreateVehicle(vehicletype, x, y, z, rotation, color1, color2, respawn_delay");
	return CreateVehicle(vehicletype, x, y, z, rotation, color1, color2, respawn_delay);
}
stock c_SetPlayerRaceCheckpoint(playerid, type, Float:x, Float:y, Float:z, Float:nextx, Float:nexty, Float:nextz, Float:size)
{
	writelog("SetPlayerRaceCheckpoint(playerid, type, x,y, z, nextx, nexty, nextz, size);");
	return SetPlayerRaceCheckpoint(playerid, type, x, y, z, nextx, nexty, nextz, size);
}
stock c_ApplyAnimation(playerid, animlib[], animname[], Float:fS, opt1, opt2, opt3, opt4, opt5)
{
	writelog("ApplyAnimation(playerid, animlib, animname, fS, opt1, opt2, opt3, opt4, opt5);");
	return ApplyAnimation(playerid, animlib, animname, fS, opt1, opt2, opt3, opt4, opt5);
}

#define heapspace(%1) c_heapspace(%1)
#define funcidx(%1) c_funcidx(%1)
#define numargs(%1) c_numargs(%1)
#define getarg(%1) c_getarg(%1)
#define setarg(%1) c_setarg(%1)
#define tolower(%1) c_tolower(%1)
#define toupper(%1) c_toupper(%1)
#define swapchars(%1) c_swapchars(%1)
#define random(%1) c_random(%1)
#define min(%1) c_min(%1)
#define max(%1) c_max(%1)
#define clamp(%1) c_clamp(%1)
#define getproperty(%1) c_getproperty(%1)
#define setproperty(%1) c_setproperty(%1)
#define deleteproperty(%1) c_deleteproperty(%1)
#define existproperty(%1) c_existproperty(%1)
#define sendstring(%1) c_sendstring(%1)
#define sendpacket(%1) c_sendpacket(%1)
#define listenport(%1) c_listenport(%1)
#define fopen(%1) c_fopen(%1)
#define fclose(%1) c_fclose(%1)
#define ftemp(%1) c_ftemp(%1)
#define fremove(%1) c_fremove(%1)
#define fwrite(%1) c_fwrite(%1)
//#define fread(%1) c_fread(%1)
#define fputchar(%1) c_fputchar(%1)
#define fgetchar(%1) c_fgetchar(%1)
#define fblockwrite(%1) c_fblockwrite(%1)
#define fblockread(%1) c_fblockread(%1)
#define fseek(%1) c_fseek(%1)
#define flength(%1) c_flength(%1)
#define fexist(%1) c_fexist(%1)
#define fmatch(%1) c_fmatch(%1)
/*#define float(%1) c_float(%1)
#define floatstr(%1) c_floatstr(%1)
#define floatmul(%1) c_floatmul(%1)
#define floatdiv(%1) c_floatdiv(%1)
#define floatadd(%1) c_floatadd(%1)
#define floatsub(%1) c_floatsub(%1)
#define floatfract(%1) c_floatfract(%1)
#define floatround(%1) c_floatround(%1)
#define floatcmp(%1) c_floatcmp(%1)
#define floatsqroot(%1) c_floatsqroot(%1)
#define floatpower(%1) c_floatpower(%1)
#define floatlog(%1) c_floatlog(%1)
#define floatsin(%1) c_floatsin(%1)
#define floatcos(%1) c_floatcos(%1)
#define floattan(%1) c_floattan(%1)
#define strlen(%1) c_strlen(%1)
#define strpack(%1) c_strpack(%1)
#define strunpack(%1) c_strunpack(%1)
#define strcat(%1) c_strcat(%1)
#define strmid(%1) c_strmid(%1)
#define  strins(%1) c_strins(%1)
#define  strdel(%1) c_strdel(%1)
#define strcmp(%1) c_strcmp(%1)
#define strfind(%1) c_strfind(%1)
#define strval(%1) c_strval(%1)
#define valstr(%1) c_valstr(%1)*/
#define  ispacked(%1) c_ispacked(%1)
#define uudecode(%1) c_uudecode(%1)
#define uuencode(%1) c_uuencode(%1)
#define memcpy(%1) c_memcpy(%1)
#define gettime(%1) c_gettime(%1)
#define getdate(%1) c_getdate(%1)
#define tickcount(%1) c_tickcount(%1)
#define CreateVehicle(%1) c_CreateVehicle(%1)
#define DestroyVehicle(%1) c_DestroyVehicle(%1)
#define GetVehiclePos(%1) c_GetVehiclePos(%1)
#define SetVehiclePos(%1) c_SetVehiclePos(%1)
#define GetVehicleZAngle(%1) c_GetVehicleZAngle(%1)
#define SetVehicleZAngle(%1) c_SetVehicleZAngle(%1)
#define SetVehicleParamsForPlayer(%1) c_SetVehicleParamsForPlayer(%1)
#define SetVehicleToRespawn(%1) c_SetVehicleToRespawn(%1)
#define LinkVehicleToInterior(%1) c_LinkVehicleToInterior(%1)
#define AddVehicleComponent(%1) c_AddVehicleComponent(%1)
#define RemoveVehicleComponent(%1) c_RemoveVehicleComponent(%1)
#define ChangeVehicleColor(%1) c_ChangeVehicleColor(%1)
#define ChangeVehiclePaintjob(%1) c_ChangeVehiclePaintjob(%1)
#define SetVehicleHealth(%1) c_SetVehicleHealth(%1)
#define GetVehicleHealth(%1) c_GetVehicleHealth(%1)
#define AttachTrailerToVehicle(%1) c_AttachTrailerToVehicle(%1)
#define DetachTrailerFromVehicle(%1) c_DetachTrailerFromVehicle(%1)
#define IsTrailerAttachedToVehicle(%1) c_IsTrailerAttachedToVehicle(%1)
#define GetVehicleTrailer(%1) c_GetVehicleTrailer(%1)
#define SetVehicleNumberPlate(%1) c_SetVehicleNumberPlate(%1)
#define GetVehicleModel(%1) c_GetVehicleModel(%1)
#define SetVehicleVirtualWorld(%1) c_SetVehicleVirtualWorld(%1)
#define GetVehicleVirtualWorld(%1) c_GetVehicleVirtualWorld(%1)
#define CreateObject(%1) c_CreateObject(%1)
#define SetObjectPos(%1) c_SetObjectPos(%1)
#define GetObjectPos(%1) c_GetObjectPos(%1)
#define SetObjectRot(%1) c_SetObjectRot(%1)
#define GetObjectRot(%1) c_GetObjectRot(%1)
#define IsValidObject(%1) c_IsValidObject(%1)
#define DestroyObject(%1) c_DestroyObject(%1)
#define MoveObject(%1) c_MoveObject(%1)
#define StopObject(%1) c_StopObject(%1)
#define CreatePlayerObject(%1) c_CreatePlayerObject(%1)
#define SetPlayerObjectPos(%1) c_SetPlayerObjectPos(%1)
#define GetPlayerObjectPos(%1) c_GetPlayerObjectPos(%1)
#define SetPlayerObjectRot(%1) c_SetPlayerObjectRot(%1)
#define GetPlayerObjectRot(%1) c_GetPlayerObjectRot(%1)
#define IsValidPlayerObject(%1) c_IsValidPlayerObject(%1)
#define DestroyPlayerObject(%1) c_DestroyPlayerObject(%1)
#define MovePlayerObject(%1) c_MovePlayerObject(%1)
#define StopPlayerObject(%1) c_StopPlayerObject(%1)
#define AttachObjectToPlayer(%1) c_AttachObjectToPlayer(%1)
#define AttachPlayerObjectToPlayer(%1) c_AttachPlayerObjectToPlayer(%1)
#define SetSpawnInfo(%1) c_SetSpawnInfo(%1)
#define SpawnPlayer(%1) c_SpawnPlayer(%1)
#define SetPlayerPos(%1) c_SetPlayerPos(%1)
#define SetPlayerPosFindZ(%1) c_SetPlayerPosFindZ(%1)
#define GetPlayerPos(%1) c_GetPlayerPos(%1)
#define SetPlayerFacingAngle(%1) c_SetPlayerFacingAngle(%1)
#define GetPlayerFacingAngle(%1) c_GetPlayerFacingAngle(%1)
#define SetPlayerInterior(%1) c_SetPlayerInterior(%1)
#define GetPlayerInterior(%1) c_GetPlayerInterior(%1)
#define SetPlayerHealth(%1) c_SetPlayerHealth(%1)
#define GetPlayerHealth(%1) c_GetPlayerHealth(%1)
#define SetPlayerArmour(%1) c_SetPlayerArmour(%1)
#define GetPlayerArmour(%1) c_GetPlayerArmour(%1)
#define SetPlayerAmmo(%1) c_SetPlayerAmmo(%1)
#define GetPlayerAmmo(%1) c_GetPlayerAmmo(%1)
#define SetPlayerTeam(%1) c_SetPlayerTeam(%1)
#define GetPlayerTeam(%1) c_GetPlayerTeam(%1)
#define SetPlayerScore(%1) c_SetPlayerScore(%1)
#define GetPlayerScore(%1) c_GetPlayerScore(%1)
#define SetPlayerColor(%1) c_SetPlayerColor(%1)
#define GetPlayerColor(%1) c_GetPlayerColor(%1)
#define SetPlayerSkin(%1) c_SetPlayerSkin(%1)
#define GetPlayerSkin(%1) c_GetPlayerSkin(%1)
#define GivePlayerWeapon(%1) c_GivePlayerWeapon(%1)
#define ResetPlayerWeapons(%1) c_ResetPlayerWeapons(%1)
#define GetPlayerWeaponData(%1) c_GetPlayerWeaponData(%1)
#define GivePlayerMoney(%1) c_GivePlayerMoney(%1)
#define ResetPlayerMoney(%1) c_ResetPlayerMoney(%1)
#define SetPlayerName(%1) c_SetPlayerName(%1)
#define GetPlayerMoney(%1) c_GetPlayerMoney(%1)
#define GetPlayerState(%1) c_GetPlayerState(%1)
#define GetPlayerIp(%1) c_GetPlayerIp(%1)
#define GetPlayerPing(%1) c_GetPlayerPing(%1)
#define GetPlayerWeapon(%1) c_GetPlayerWeapon(%1)
#define GetPlayerKeys(%1) c_GetPlayerKeys(%1)
#define GetPlayerName(%1) c_GetPlayerName(%1)
#define SetPlayerTime(%1) c_SetPlayerTime(%1)
#define GetPlayerTime(%1) c_GetPlayerTime(%1)
#define TogglePlayerClock(%1) c_TogglePlayerClock(%1)
#define SetPlayerWeather(%1) c_SetPlayerWeather(%1)
#define ForceClassSelection(%1) c_ForceClassSelection(%1)
#define SetPlayerWantedLevel(%1) c_SetPlayerWantedLevel(%1)
#define GetPlayerWantedLevel(%1) c_GetPlayerWantedLevel(%1)
#define PutPlayerInVehicle(%1) c_PutPlayerInVehicle(%1)
#define GetPlayerVehicleID(%1) c_GetPlayerVehicleID(%1)
#define RemovePlayerFromVehicle(%1) c_RemovePlayerFromVehicle(%1)
#define TogglePlayerControllable(%1) c_TogglePlayerControllable(%1)
#define PlayerPlaySound(%1) c_PlayerPlaySound(%1)
#define ApplyAnimation(%1) c_ApplyAnimation(%1)
#define ClearAnimations(%1) c_ClearAnimations(%1)
#define GetPlayerSpecialAction(%1) c_GetPlayerSpecialAction(%1)
#define SetPlayerSpecialAction(%1) c_SetPlayerSpecialAction(%1)
#define SetPlayerCheckpoint(%1) c_SetPlayerCheckpoint(%1)
#define DisablePlayerCheckpoint(%1) c_DisablePlayerCheckpoint(%1)
#define SetPlayerRaceCheckpoint(%1) c_SetPlayerRaceCheckpoint(%1)
#define DisablePlayerRaceCheckpoint(%1) c_DisablePlayerRaceCheckpoint(%1)
#define SetPlayerWorldBounds(%1) c_SetPlayerWorldBounds(%1)
#define SetPlayerMarkerForPlayer(%1) c_SetPlayerMarkerForPlayer(%1)
#define ShowPlayerNameTagForPlayer(%1) c_ShowPlayerNameTagForPlayer(%1)
#define SetPlayerMapIcon(%1) c_SetPlayerMapIcon(%1)
#define RemovePlayerMapIcon(%1) c_RemovePlayerMapIcon(%1)
#define SetPlayerCameraPos(%1) c_SetPlayerCameraPos(%1)
#define SetPlayerCameraLookAt(%1) c_SetPlayerCameraLookAt(%1)
#define SetCameraBehindPlayer(%1) c_SetCameraBehindPlayer(%1)
#define AllowPlayerTeleport(%1) c_AllowPlayerTeleport(%1)
#define IsPlayerConnected(%1) c_IsPlayerConnected(%1)
#define IsPlayerInVehicle(%1) c_IsPlayerInVehicle(%1)
#define IsPlayerInAnyVehicle(%1) c_IsPlayerInAnyVehicle(%1)
#define IsPlayerInCheckpoint(%1) c_IsPlayerInCheckpoint(%1)
#define IsPlayerInRaceCheckpoint(%1) c_IsPlayerInRaceCheckpoint(%1)
#define SetPlayerVirtualWorld(%1) c_SetPlayerVirtualWorld(%1)
#define GetPlayerVirtualWorld(%1) c_GetPlayerVirtualWorld(%1)
#define EnableStuntBonusForPlayer(%1) c_EnableStuntBonusForPlayer(%1)
#define EnableStuntBonusForAll(%1) c_EnableStuntBonusForAll(%1)
#define TogglePlayerSpectating(%1) c_TogglePlayerSpectating(%1)
#define PlayerSpectatePlayer(%1) c_PlayerSpectatePlayer(%1)
#define PlayerSpectateVehicle(%1) c_PlayerSpectateVehicle(%1)
#define print(%1) c_print(%1)
#define SendClientMessage(%1) c_SendClientMessage(%1)
#define SendClientMessageToAll(%1) c_SendClientMessageToAll(%1)
#define SendPlayerMessageToPlayer(%1) c_SendPlayerMessageToPlayer(%1)
#define SendPlayerMessageToAll(%1) c_SendPlayerMessageToAll(%1)
#define SendDeathMessage(%1) c_SendDeathMessage(%1)
#define GameTextForAll(%1) c_GameTextForAll(%1)
#define GameTextForPlayer(%1) c_GameTextForPlayer(%1)
#define SetTimer(%1) c_SetTimer(%1)
#define KillTimer(%1) c_KillTimer(%1)
#define GetTickCount(%1) c_GetTickCount(%1)
#define GetMaxPlayers(%1) c_GetMaxPlayers(%1)
#define LimitGlobalChatRadius(%1) c_LimitGlobalChatRadius(%1)
#define asin(%1) c_asin(%1)
#define acos(%1) c_acos(%1)
#define atan(%1) c_atan(%1)
#define atan2(%1) c_atan2(%1)
#define SetGameModeText(%1) c_SetGameModeText(%1)
#define SetTeamCount(%1) c_SetTeamCount(%1)
#define AddPlayerClass(%1) c_AddPlayerClass(%1)
#define AddPlayerClassEx(%1) c_AddPlayerClassEx(%1)
#define AddStaticVehicle(%1) c_AddStaticVehicle(%1)
#define AddStaticVehicleEx(%1) c_AddStaticVehicleEx(%1)
#define AddStaticPickup(%1) c_AddStaticPickup(%1)
#define CreatePickup(%1) c_CreatePickup(%1)
#define DestroyPickup(%1) c_DestroyPickup(%1)
#define ShowNameTags(%1) c_ShowNameTags(%1)
#define ShowPlayerMarkers(%1) c_ShowPlayerMarkers(%1)
#define GameModeExit(%1) c_GameModeExit(%1)
#define SetWorldTime(%1) c_SetWorldTime(%1)
#define GetWeaponName(%1) c_GetWeaponName(%1)
#define EnableTirePopping(%1) c_EnableTirePopping(%1)
#define AllowInteriorWeapons(%1) c_AllowInteriorWeapons(%1)
#define SetWeather(%1) c_SetWeather(%1)
#define SetGravity(%1) c_SetGravity(%1)
#define AllowAdminTeleport(%1) c_AllowAdminTeleport(%1)
#define SetDeathDropAmount(%1) c_SetDeathDropAmount(%1)
#define CreateExplosion(%1) c_CreateExplosion(%1)
#define EnableZoneNames(%1) c_EnableZoneNames(%1)
#define UsePlayerPedAnims(%1)		 c_UsePlayerPedAnims(%1)
#define DisableInteriorEnterExits(%1)   c_DisableInteriorEnterExits(%1)
#define SetNameTagDrawDistance(%1)  c_SetNameTagDrawDistance(%1)
#define IsPlayerAdmin(%1) c_IsPlayerAdmin(%1)
#define Kick(%1) c_Kick(%1)
#define Ban(%1) c_Ban(%1)
#define BanEx(%1) c_BanEx(%1)
#define SendRconCommand(%1) c_SendRconCommand(%1)
#define GetServerVarAsString(%1) c_GetServerVarAsString(%1)
#define GetServerVarAsInt(%1) c_GetServerVarAsInt(%1)
#define GetServerVarAsBool(%1) c_GetServerVarAsBool(%1)
#define CreateMenu(%1) c_CreateMenu(%1)
#define DestroyMenu(%1) c_DestroyMenu(%1)
#define AddMenuItem(%1) c_AddMenuItem(%1)
#define SetMenuColumnHeader(%1) c_SetMenuColumnHeader(%1)
#define ShowMenuForPlayer(%1) c_ShowMenuForPlayer(%1)
#define HideMenuForPlayer(%1) c_HideMenuForPlayer(%1)
#define IsValidMenu(%1) c_IsValidMenu(%1)
#define DisableMenu(%1) c_DisableMenu(%1)
#define DisableMenuRow(%1) c_DisableMenuRow(%1)
#define GetPlayerMenu(%1) c_GetPlayerMenu(%1)
#define TextDrawCreate(%1) c_TextDrawCreate(%1)
#define TextDrawDestroy(%1) c_TextDrawDestroy(%1)
#define TextDrawLetterSize(%1) c_TextDrawLetterSize(%1)
#define TextDrawTextSize(%1) c_TextDrawTextSize(%1)
#define TextDrawAlignment(%1) c_TextDrawAlignment(%1)
#define TextDrawColor(%1) c_TextDrawColor(%1)
#define TextDrawUseBox(%1) c_TextDrawUseBox(%1)
#define TextDrawBoxColor(%1) c_TextDrawBoxColor(%1)
#define TextDrawSetShadow(%1) c_TextDrawSetShadow(%1)
#define TextDrawSetOutline(%1) c_TextDrawSetOutline(%1)
#define TextDrawBackgroundColor(%1) c_TextDrawBackgroundColor(%1)
#define TextDrawFont(%1) c_TextDrawFont(%1)
#define TextDrawSetProportional(%1) c_TextDrawSetProportional(%1)
#define TextDrawShowForPlayer(%1) c_TextDrawShowForPlayer(%1)
#define TextDrawHideForPlayer(%1) c_TextDrawHideForPlayer(%1)
#define TextDrawShowForAll(%1) c_TextDrawShowForAll(%1)
#define TextDrawHideForAll(%1) c_TextDrawHideForAll(%1)
#define TextDrawSetString(%1) c_TextDrawSetString(%1)
#define GangZoneCreate(%1) c_GangZoneCreate(%1)
#define GangZoneDestroy(%1) c_GangZoneDestroy(%1)
#define GangZoneShowForPlayer(%1) c_GangZoneShowForPlayer(%1)
#define GangZoneShowForAll(%1) c_GangZoneShowForAll(%1)
#define GangZoneHideForPlayer(%1) c_GangZoneHideForPlayer(%1)
#define GangZoneHideForAll(%1) c_GangZoneHideForAll(%1)
#define GangZoneFlashForPlayer(%1) c_GangZoneFlashForPlayer(%1)
#define GangZoneFlashForAll(%1) c_GangZoneFlashForAll(%1)
#define GangZoneStopFlashForPlayer(%1) c_GangZoneStopFlashForPlayer(%1)
#define GangZoneStopFlashForAll(%1) c_GangZoneStopFlashForAll(%1)


stock c_OnGameModeInit()
{
	new string_[50];
	format(string_,50,"OnGameModeInit()");
	writelog(string_);
	return CallLocalFunction("OnGameModeInit","");
}
stock c_OnGameModeExit()
{
	new string_[50];
	format(string_,50,"OnGameModeExit()");
	writelog(string_);
	return CallLocalFunction("OnGameModeExit","");
}
stock c_OnFilterScriptInit()
{
	new string_[50];
	format(string_,50,"OnFilterScriptInit()");
	writelog(string_);
	return CallLocalFunction("OnFilterScriptInit","");
}

stock c_OnFilterScriptExit()
{
	new string_[50];
	format(string_,50,"OnFilterScriptExit()");
	writelog(string_);
	return CallLocalFunction("OnFilterScriptExit","");
}
stock c_OnPlayerConnect(playerid)
{
	new string_[50];
	format(string_,50,"OnPlayerConnect(%d)",playerid);
	writelog(string_);
	return CallLocalFunction("OnPlayerConnect","i",playerid);
}
stock c_OnPlayerDisconnect(playerid, reason)
{
	new string_[50];
	format(string_,50,"OnPlayerDisconnect(%d,%d)",playerid,reason);
	writelog(string_);
	return CallLocalFunction("OnPlayerDisconnect","ii",playerid,reason);
}
stock c_OnPlayerSpawn(playerid)
{
	new string_[50];
	format(string_,50,"OnPlayerSpawn(%d)");
	writelog(string_);
	return CallLocalFunction("OnPlayerSpawn","i",playerid);
}
stock c_OnPlayerDeath(playerid, killerid, reason)
{
	new string_[50];
	format(string_,50,"OnPlayerDeath(%d,%d,%d)");
	writelog(string_);
	return CallLocalFunction("OnPlayerDeath","iii",playerid,killerid,reason);
}
stock c_OnVehicleSpawn(vehicleid)
{
	new string_[50];
	format(string_,50,"OnVehicleSpawn(%d)",vehicleid);
	writelog(string_);
	return CallLocalFunction("OnVehicleSpawn","i",vehicleid);
}
stock c_OnVehicleDeath(vehicleid, killerid)
{
	new string_[50];
	format(string_,50,"OnVehicleDeath(%d,%d)",vehicleid,killerid);
	writelog(string_);
	return CallLocalFunction("OnVehicleDeath","ii",vehicleid,killerid);
}
stock c_OnPlayerText(playerid, text[])
{
	new string_[50];
	format(string_,50,"OnPlayerText(%d,%s)",playerid,text);
	writelog(string_);
	return CallLocalFunction("OnPlayerText","is",playerid,text);
}
stock c_OnPlayerCommandText(playerid, cmdtext[])
{
	new string_[50];
	format(string_,50,"OnPlayerCommandText(%d,%s)",playerid,cmdtext);
	writelog(string_);
	return CallLocalFunction("OnPlayerCommandText","is",playerid,cmdtext);
}
stock c_OnPlayerInfoChange(playerid)
{
	new string_[50];
	format(string_,50,"OnPlayerInfoChange(%d)",playerid);
	writelog(string_);
	return CallLocalFunction("OnPlayerInfoChange","i",playerid);
}
stock c_OnPlayerRequestClass(playerid, classid)
{
	new string_[50];
	format(string_,50,"OnPlayerRequestClass(%d,%d)",playerid,classid);
	writelog(string_);
	return CallLocalFunction("OnPlayerRequestClass","ii",playerid,classid);
}
stock c_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	new string_[50];
	format(string_,50,"OnPlayerEnterVehicle(%d,%d,%d)",playerid,vehicleid,ispassenger);
	writelog(string_);
	return CallLocalFunction("OnFilterScriptExit","iii",playerid,vehicleid,ispassenger);
}
stock c_OnPlayerExitVehicle(playerid, vehicleid)
{
	new string_[50];
	format(string_,50,"OnPlayerExitVehicle(%d,%d)",playerid,vehicleid);
	writelog(string_);
	return CallLocalFunction("OnPlayerExitVehicle","ii",playerid,vehicleid);
}
stock c_OnPlayerStateChange(playerid, newstate, oldstate)
{
	new string_[50];
	format(string_,50,"OnPlayerStateChange(%d,%d,%d)",playerid,newstate,oldstate);
	writelog(string_);
	return CallLocalFunction("OnFilterScriptExit","iii",playerid,newstate,oldstate);
}
stock c_OnPlayerEnterCheckpoint(playerid)
{
	new string_[50];
	format(string_,50,"OnPlayerEnterCheckpoint(%d)",playerid);
	writelog(string_);
	return CallLocalFunction("OnPlayerEnterCheckpoint","i",playerid);
}
stock c_OnPlayerLeaveCheckpoint(playerid)
{
	new string_[50];
	format(string_,50,"OnPlayerLeaveCheckpoint(%d)",playerid);
	writelog(string_);
	return CallLocalFunction("OnPlayerLeaveCheckpoint","i",playerid);
}
stock c_OnPlayerEnterRaceCheckpoint(playerid)
{
	new string_[50];
	format(string_,50,"OnPlayerEnterRaceCheckpoint(%d)",playerid);
	writelog(string_);
	return CallLocalFunction("OnPlayerEnterRaceCheckpoint","i",playerid);
}
stock c_OnPlayerLeaveRaceCheckpoint(playerid)
{
	new string_[50];
	format(string_,50,"OnPlayerLeaveRaceCheckpoint(%d)",playerid);
	writelog(string_);
	return CallLocalFunction("OnPlayerLeaveRaceCheckpoint","i",playerid);
}
stock c_OnRconCommand(cmd[])
{
	new string_[50];
	format(string_,50,"OnRconCommand(%s),"cmd);
	writelog(string_);
	return CallLocalFunction("OnRconCommand","s",cmd);
}
stock c_OnPlayerPrivmsg(playerid, recieverid, text[])
{
	new string_[50];
	format(string_,50,"OnPlayerPrivmsg(%d,%d,%s)",playerid,recieverid,text);
	writelog(string_);
	return CallLocalFunction("OnPlayerPrivmsg","iis",playerid,recieverid,text);
}
stock c_OnPlayerRequestSpawn(playerid)
{
	new string_[50];
	format(string_,50,"OnPlayerRequestSpawn(%d)",playerid);
	writelog(string_);
	return CallLocalFunction("OnPlayerRequestSpawn","i",playerid);
}
stock c_OnObjectMoved(objectid)
{
	new string_[50];
	format(string_,50,"OnObjectMoved(%d)",playerid);
	writelog(string_);
	return CallLocalFunction("OnObjectMoved","i",playerid);
}
stock c_OnPlayerObjectMoved(playerid, objectid)
{
	new string_[50];
	format(string_,50,"OnPlayerObjectMoved(%d,%d)",playerid,objectid);
	writelog(string_);
	return CallLocalFunction("OnPlayerObjectMoved","ii",playerid,objectid);
}
stock c_OnPlayerPickUpPickup(playerid, pickupid)
{
	new string_[50];
	format(string_,50,"OnPlayerPickUpPickup(%d,%d)",playerid,pickupid);
	writelog(string_);
	return CallLocalFunction("OnPlayerPickUpPickup","ii",playerid,pickupid);
}
stock c_OnVehicleMod(vehicleid, componentid)
{
	new string_[50];
	format(string_,50,"OnVehicleMod(%d,%d)",vehicleid,componentid);
	writelog(string_);
	return CallLocalFunction("OnVehicleMod","ii",vehicleid,componentid);
}
stock c_OnVehiclePaintjob(vehicleid, paintjobid)
{
	new string_[50];
	format(string_,50,"OnVehiclePaintjob(%d,%d)",vehicleid,paintjobid);
	writelog(string_);
	return CallLocalFunction("OnVehiclePaintjob","ii",vehicleid,paintjobid);
}
stock c_OnVehicleRespray(vehicleid, color1, color2)
{
	new string_[50];
	format(string_,50,"OnVehicleRespray(%d,%d,%d)",vehicleid,color1,color2);
	writelog(string_);
	return CallLocalFunction("OnVehicleRespray","iii",vehicleid,color1,color2);
}
stock c_OnPlayerSelectedMenuRow(playerid, row)
{
	new string_[50];
	format(string_,50,"OnPlayerSelectedMenuRow(%d,%d)",playerid,row);
	writelog(string_);
	return CallLocalFunction("OnPlayerSelectedMenuRow","ii",playerid,row);
}
stock c_OnPlayerExitedMenu(playerid)
{
	new string_[50];
	format(string_,50,"OnPlayerExitedMenu(%d)",playerid);
	writelog(string_);
	return CallLocalFunction("OnPlayerExitedMenu","i",playerid);
}
stock c_OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	new string_[50];
	format(string_,50,"OnPlayerInteriorChange(%d,%d,%d)",playerid,newinteriorid,oldinteriorid);
	writelog(string_);
	return CallLocalFunction("OnPlayerInteriorChange","iii",playerid,newinteriorid,oldinteriorid);
}
stock c_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	new string_[50];
	format(string_,50,"OnPlayerKeyStateChange(%d,%d,%d)",playerid,newkeys,oldkeys);
	writelog(string_);
	return CallLocalFunction("OnPlayerKeyStateChange","iii",playerid,newkeys,oldkeys);
}

#define OnGameModeInit(); c_OnGameModeInit();
#define OnGameModeExit(); c_OnGameModeExit();
#define OnFilterScriptInit(); c_OnFilterScriptInit();
#define OnFilterScriptExit(); c_OnFilterScriptExit();
#define OnPlayerConnect(%1); c_OnPlayerConnect(%1);
#define OnPlayerDisconnect(%1); c_OnPlayerDisconnect(%1);
#define OnPlayerSpawn(%1); c_OnPlayerSpawn(%1);
#define OnPlayerDeath(%1); c_OnPlayerDeath(%1);
#define OnVehicleSpawn(%1); c_OnVehicleSpawn(%1);
#define OnVehicleDeath(%1); c_OnVehicleDeath(%1);
#define OnPlayerText(%1); c_OnPlayerText(%1);
#define OnPlayerCommandText(%1); c_OnPlayerCommandText(%1);
#define OnPlayerInfoChange(%1); c_OnPlayerInfoChange(%1);
#define OnPlayerRequestClass(%1); c_OnPlayerRequestClass(%1);
#define OnPlayerEnterVehicle(%1); c_OnPlayerEnterVehicle(%1);
#define OnPlayerExitVehicle(%1); c_OnPlayerExitVehicle(%1);
#define OnPlayerStateChange(%1); c_OnPlayerStateChange(%1);
#define OnPlayerEnterCheckpoint(%1); c_OnPlayerEnterCheckpoint(%1);
#define OnPlayerLeaveCheckpoint(%1); c_OnPlayerLeaveCheckpoint(%1);
#define OnPlayerEnterRaceCheckpoint(%1); c_OnPlayerEnterRaceCheckpoint(%1);
#define OnPlayerLeaveRaceCheckpoint(%1); c_OnPlayerLeaveRaceCheckpoint(%1);
#define OnRconCommand(%1); c_OnRconCommand(%1);
#define OnPlayerPrivmsg(%1); c_OnPlayerPrivmsg(%1);
#define OnPlayerRequestSpawn(%1); c_OnPlayerRequestSpawn(%1);
#define OnObjectMoved(%1); c_OnObjectMoved(%1);
#define OnPlayerObjectMoved(%1); c_OnPlayerObjectMoved(%1);
#define OnPlayerPickUpPickup(%1); c_OnPlayerPickUpPickup(%1);
#define OnVehicleMod(%1); c_OnVehicleMod(%1);
#define OnVehiclePaintjob(%1); c_OnVehiclePaintjob(%1);
#define OnVehicleRespray(%1); c_OnVehicleRespray(%1);
#define OnPlayerSelectedMenuRow(%1); c_OnPlayerSelectedMenuRow(%1);
#define OnPlayerExitedMenu(%1); c_OnPlayerExitedMenu(%1);
#define OnPlayerInteriorChange(%1); c_OnPlayerInteriorChange(%1);
#define OnPlayerKeyStateChange(%1); c_OnPlayerKeyStateChange(%1);
