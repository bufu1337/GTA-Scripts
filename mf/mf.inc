#include <a_samp>
new onid[MAX_PLAYERS];
new sonid[MAX_PLAYERS];
new oldpmoney[MAX_PLAYERS];
new oldpscore[MAX_PLAYERS];
new oldid[MAX_PLAYERS];
new soldid[MAX_PLAYERS];
new pmoney[MAX_PLAYERS];
new pscore[MAX_PLAYERS];
new suspici[MAX_PLAYERS];
new done = 0;
new suspic = 10000000;
new suspicincrease = 100000;
public defining(){
for (new i = 0; i < MAX_PLAYERS; i++)
{
oldpmoney[i] = 0;
oldpscore[i] = 0;
pmoney[i] = 0;
pscore[i] = 0;
oldid[i] = -1;
onid[i] = -1;
soldid[i] = -1;
sonid[i] = -1;
suspici[i] = 0;
}}
public mflogout(i){
	oldpmoney[i] = 0;
	oldpscore[i] = 0;
	pmoney[i] = 0;
	pscore[i] = 0;
	oldid[i] = -1;
	onid[i] = -1;
	soldid[i] = -1;
	sonid[i] = -1;
	suspici[i] = 0;
    }
// Callbacks
public MoneyCheck(){
    for (new i = 0; i < MAX_PLAYERS; i++)	
	{
	if(IsPlayerConnected(i)){
   	pmoney[i] = GetPlayerMoney(i);
	if(onid[i] != -1 && oldid[i] == -1){
	oldid[i] = i;
	oldpmoney[i] == GetPlayerMoney(i);}
	else{	
	if((pmoney[i] - oldpmoney[i]) >= suspicincrease){
	#if defined OnPlayerMoneySuspiciousIncrease
	OnPlayerMoneySuspiciousIncrease(i,(pmoney[i] - oldpmoney[i]));
	#endif
	}
	if(oldpmoney[i] != pmoney[i]){
	#if defined OnPlayerMoneyChange
	OnPlayerMoneyChange(i,pmoney[i],oldpmoney[i],(pmoney[i] - oldpmoney[i]));
	#endif
	}
	}
	}}
	}
public ScoreCheck(){
    for (new i = 0; i < MAX_PLAYERS; i++)
	{
	if(IsPlayerConnected(i)){
   	pscore[i] = GetPlayerScore(i);
	if(sonid[i] != -1 && soldid[i] == -1){
	soldid[i] = i;
	oldpscore[i] == GetPlayerMoney(i);}
	else{
	if(oldpscore[i] != pscore[i]){
	#if defined OnPlayerScoreChange
	OnPlayerScoreChange(i,pscore[i],oldpscore[i],(pscore[i] - oldpscore[i]));
	#endif
	}
	}
	oldpscore[i] = pscore[i];
	}}
	}
public SuspiciousCheck(){
    for (new i = 0; i < MAX_PLAYERS; i++)
	{
	if(IsPlayerConnected(i)){
	new mney = GetPlayerMoney(i);
	if(mney >= suspic){
	if(!suspici[i]){
	suspici[i] = 1;
	#if defined OnPlayerSuspiciousMoney
	OnPlayerSuspiciousMoney(i,mney);
	#endif
	}
	else{}
	}
	else{
	if(suspici[i]){
	suspici[i] = 0;}
	}
	}}
	}
// Functions
public SetSuspiciousMoneyValue(value){
suspic = value;
}
public GetSuspiciousMoneyValue(){
return suspic;
}
public SetSuspiciousMoneyIncreaseValue(value){
suspicincrease = value;
}
public GetSuspiciousMoneyIncreaseValue(){
return suspicincrease;
}
public KickAll(){
    for (new i = 0; i < MAX_PLAYERS; i++)
	{
    if(IsPlayerConnected(i)){
	Kick(i);}
	}}
public GiveTeamWeapon(teamid,weaponid,ammo){
    for (new i = 0; i < MAX_PLAYERS; i++)
	{
	if(IsPlayerConnected(i)){
	new tid = GetPlayerTeam(i);
	if(tid == teamid){
	GivePlayerWeapon(i,weaponid,ammo);
	}
	else{}
	}}
}
public ResetTeamWeapons(teamid){
    for (new i = 0; i < MAX_PLAYERS; i++)
	{
	if(IsPlayerConnected(i)){
	new tid = GetPlayerTeam(i);
	if(tid == teamid){
	ResetPlayerWeapons(i);
	}
	else{}
	}}
}
public SetTeamScore(teamid,score){
    for (new i = 0; i < MAX_PLAYERS; i++)
	{
	if(IsPlayerConnected(i)){
	new tid = GetPlayerTeam(i);
	if(tid == teamid){
	SetPlayerScore(i, score);
	}
	else{}
	}}}
public mftimer(){
if(!done){
done = 1;
defining();
}else{}
ScoreCheck();
SuspiciousCheck();
MoneyCheck();
}
