#include <a_samp>
#include <KIHC>
//#defined FILTERSCRIPT
#if defined FILTERSCRIPT

public OnFilterScriptInit(){
return 1;}
public OnFilterScriptExit(){
return 1;}
#else
main(){}
#endif
public OnPlayerCommandText(playerid, cmdtext[]){
OnPlayerCmdText(playerid, cmdtext);}
public OnPlayerSelectedMenuRow(playerid, row){
OnPlayerSelectMenuRow(playerid, row);}
public OnPlayerExitedMenu(playerid){
OnPlayerExitMenu(playerid);}

