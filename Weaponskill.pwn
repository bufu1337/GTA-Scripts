/*______________________________________________________________________________________________________________________

								[Include]L-Skills
								Server sided Skill system!
								By Lordz™.
								Copyright(c) 2013 - L-Skills
								Version: 1.2

This is a server sided Skill system created by me, Lordz, which allows setting skill for most of the weapons. In SA-MP,
there's a default function "SetPlayerSkillLevel" which increases the skill and gives player advanced combat controls. However,
it isn't supported with all weapons so I thought of creating something as I was bored and was trying to get some ideas. Just got on this,
so I created this. What this does is, it advances the combat! As there's more skill there for player, it does more damage. The default
damage value set here is 999. It's better not to change it as I've coded the settings according to that only. If I might develop this
include, I might create an easy settings for that too.  This include has some other custom functions too which I've explained in the script too - it's usage.
Also added a function called "GetPlayerSkillLevel" which gets the player's skill of function "SetPlayerSkillLevel"

NOTE:
1)Here "LS" used means L_Skill, not Los Santos or anything else!
2) Don't set the skill less than 10!
3) As skills increase, if player's server sided skill is enabled, while giving damage to other player, it damages more than the default one does.
4) How damage works is like it divides the skill by 10, and then it damages. So if your weapon skill is 10, it does 1 damage. I
 If it's 100, it does 10% damage. If it's 999, it does 99.9% of damage. MAX damage value is 999.
5) You can also automatically turn on the normal SA-MP Skill according to the server sided skill just by doing:
  #define APPLY_DEFAULT_SKILL
6) This include doesn't support some weapons for the skill( Molotovs, Remote Explosives..)
7) If you're using any script as filterscript, please don't forget to define FILTERSCRIPT before includes.
 (#define FILTERSCRIPT) must be done in case if you're including this in a filterscript.

Thanks to:
[WH]Marcos - For suggesting me some ideas.
Odedara - For testing player weapon damage rates with me.
Kye - SA-MP
Lorenc_ - For the suggestion of Anti-Skill Cheats/Hacks.
[uL]Pottus & SuperViper - For bug reports.

Bugs:
Found any? Well then let me know it by posting it on the topic or by PMing me on SA-MP forums.
http://forum.sa-mp.com/member.php?u=158660

Changelogs(v1.2)
- Fixed a few bugs.
- L_Skills perform action only on active players from now, which means it don't do anything to in-afk players.
- L_Skills prevents SA-MP provided weapon skills from it's skill values being hacked and changed. (Anti-Skill Cheat)
________________________________________________________________________________________________________________________*/



#if defined L_skills_included
 #endinput
#endif

#define L_skills_included

#define L_skills_version 1.2

/*Fake natives (Functions) of L_Skills.inc

native GetPlayerSkillLevel(playerid, weapontype);
native SetPlayerWeaponSkill(playerid, weaponid, skill);
native GetPlayerWeaponSkill(playerid, weaponid);
native GetWeaponDamageRate(weaponid);
native IsPlayerWeaponSkillEnabled(playerid);
native TogglePlayerWeaponSkill(playerid, bool:weapon_skill);
native DamagePlayer(playerid, Float:damage);
native EnablePlayerWeaponSkill(playerid);
native DisablePlayerWeaponSkill(playerid);

Callbacks:
OnWeaponSkillLevelSet(playerid, weaponid, skill);
*/

#if !defined samp_included
 #include <a_samp>
#endif


#define LS:: \
LSkill_

//#define APPLY_DEFAULT_SKILL //This is currently disabled, remove the "//" behind the #define to enable auto default Skill sets.
#define USE_LSKILLS_ANTICHEAT //Uncomment this if you don't want the server to be protected from weapon cheats.

//==============================================================================
//                 "SetPlayerSkillLevel" - Weapontype defines
//==============================================================================

#if !defined WEAPONSKILL_PISTOL
 #define WEAPONSKILL_PISTOL 0
#endif

#if !defined WEAPONSKILL_PISTOL_SILENCED
 #define WEAPONSKILL_PISTOL_SILENCED 1
#endif

#if !defined WEAPONSKILL_DESERT_EAGLE
 #define WEAPONSKILL_DESERT_EAGLE 2
#endif

#if !defined WEAPONSKILL_SHOTGUN
 #define WEAPONSKILL_SHOTGUN 3
#endif

#if !defined WEAPONSKILL_SWANOFF_SHOTGUN
 #define WEAPONSKILL_SWANOFF_SHOTGUN 4
#endif

#if !defined WEAPONSKILL_SPAS12_SHOTGUN
 #define WEAPONSKILL_SPAS12_SHOTGUN 5
#endif

#if !defined WEAPONSKILL_MICRO_UZI
 #define WEAPONSKILL_MICRO_UZI 6
#endif

#if !defined WEAPONSKILL_MP5
 #define WEAPONSKILL_MP5 7
#endif

#if !defined WEAPONSKILL_AK47
 #define WEAPONSKILL_AKf47 8
#endif

#if !defined WEAPONSKILL_M4
 #define WEAPONSKILL_M4 9
#endif

#if !defined WEAPONSKILL_SNIPERRIFLE
 #define WEAPONSKILL_SNIPERRIFLE 10
#endif


#define MAX_WEAPON_SKILL    999 //Max weapon skill!
//==============================================================================
//                              Damage rates (per shot)
//==============================================================================
//NOTE: If it's of hitman skills or of dual weapons, the damage rates adds.
//Also these aren't the actual value, actual values are of Float values, these are just integers, except spray can.
//Not mentioning weapon damages of remote explosives as they work well only for streamed players.
//And the damage of fist and Brass knuckles depends on fighting style and Combos.

#define WEAPON_DAMAGE_GOLF 		4
#define WEAPON_DAMAGE_NIGHT     4
#define WEAPON_DAMAGE_KNIFE     2
#define WEAPON_DAMAGE_KATANA    2
#define WEAPON_DAMAGE_BAT       4
#define WEAPON_DAMAGE_POOL      4
#define WEAPON_DAMAGE_SHOVEL    4
#define WEAPON_DAMAGE_CANE      4
#define WEAPON_DAMAGE_CHAINSAW  13
#define WEAPON_DAMAGE_DILDO     4
#define WEAPON_DAMAGE_DILDO2    2
#define WEAPON_DAMAGE_VIBRATOR  4
#define WEAPON_DAMAGE_VIBRATOR2 4
#define WEAPON_DAMAGE_FLOWER    4
#define WEAPON_DAMAGE_GRENADE   82 //If the grenade explosion occurs perfectly near the player only.
#define WEAPON_DAMAGE_PISTOL    8
#define WEAPON_DAMAGE_SILENCED  13
#define WEAPON_DAMAGE_DEAGLE    46
#define WEAPON_DAMAGE_SHOTGUN   49
#define WEAPON_DAMAGE_SWANOFF   49
#define WEAPON_DAMAGE_COMBAT    39
#define WEAPON_DAMAGE_UZI       6
#define WEAPON_DAMAGE_MP5       8
#define WEAPON_DAMAGE_TEC       WEAPON_DAMAGE_UZI
#define WEAPON_DAMAGE_AK47      9
#define WEAPON_DAMAGE_M4        WEAPON_DAMAGE_AK47
#define WEAPON_DAMAGE_RIFLE     24
#define WEAPON_DAMAGE_SNIPER    41
#define WEAPON_DAMAGE_MINIGUN   46
#define WEAPON_DAMAGE_RPG       82 //Just as the case of grenades mentioned
#define WEAPON_DAMAGE_HS        WEAPON_DAMAGE_RPG //Same case of grenades here too.
#define WEAPON_DAMAGE_SPRAY     1 //Actually it's 0.33.
#define WEAPON_DAMAGE_FIREEX    WEAPON_DAMAGE_SPRAY


//==============================================================================
//                              Enums
//==============================================================================

//-----------------------L_Skills.inc's Server sided enum-----------------------

enum L_SKILL_ENUM
{
 LS::Fist,
 LS::Knuckles,
 LS::Golf,
 LS::Night,
 LS::Knife,
 LS::Bat,
 LS::Shovel,
 LS::Pool,
 LS::Katana,
 LS::Chainsaw,
 LS::Dildo,
 LS::Dildo2,
 LS::Vibrator,
 LS::Vibrator2,
 LS::Flower,
 LS::Cane,
 LS::Grenade,
 LS::Pistol,
 LS::Silenced,
 LS::Deagle,
 LS::Shotgun,
 LS::Swanoff,
 LS::Combat,
 LS::Uzi,
 LS::Mp5,
 LS::AK47,
 LS::M4,
 LS::Tec,
 LS::Rifle,
 LS::Sniper,
 LS::RPG,
 LS::HS,
 LS::Minigun,
 LS::Spray,
 LS::FireEx,
 LS::Enabled,
}


//--------------L_Skills.inc's default skill level (SetPlayerSkillLevel)--------

enum Lskilldefault
{
 LS::WEAPONSKILL_PISTOL,
 LS::WEAPONSKILL_SPISTOL,
 LS::WEAPONSKILL_DESERT_EAGLE,
 LS::WEAPONSKILL_SHOTGUN,
 LS::WEAPONSKILL_SAWNOFF,
 LS::WEAPONSKILL_SPAS12,
 LS::WEAPONSKILL_MICRO_UZI,
 LS::WEAPONSKILL_MP5,
 LS::WEAPONSKILL_AK47,
 LS::WEAPONSKILL_M4,
 LS::WEAPONSKILL_SNIPERRIFLE,
}

new LS::DefaultSkill[MAX_PLAYERS][Lskilldefault];
new LS::SkillInfo[MAX_PLAYERS][L_SKILL_ENUM];
new LS::p_Spawned[MAX_PLAYERS],
	LS::p_OldTicks[MAX_PLAYERS],
	LS::p_Nocall[MAX_PLAYERS];

//==============================================================================
//                      Functions
//==============================================================================

/*
Function : DamagePlayer(playerid, Float:damage)
How it works: It damages player reducing the player's hp/armour. If armour is more
than the damage specified, it reduces the hp too.

Parameters:

playerid = the player to damage.
Float:damage = float value to do the damage
Returns = Returns 0 if player isn't connected, else 1.*/

stock DamagePlayer(playerid, Float:damage)
{
 if(!IsPlayerConnected(playerid)) return 0;
 new Float:temp_hp, Float:temp_arm;
 GetPlayerHealth(playerid, temp_hp);
 GetPlayerArmour(playerid, temp_arm);
 if(temp_arm <= 0)
 {
  SetPlayerHealth(playerid, temp_hp - damage);
 }
 else if(temp_arm >= 1.00)
 {
  new Float:minus_result = temp_arm - damage;
  if(minus_result <= 0.00)
  {
   SetPlayerArmour(playerid, 0.00);
   SetPlayerHealth(playerid, minus_result + temp_hp);
  }
  else if(minus_result >= 1.00)
  {
   SetPlayerArmour(playerid, minus_result);
  }
 }
 return 1;
}

/*
Function: GetPlayerSkillLevel(playerid, weapontype)
How it works: It returns the SkillLevel of the player which has been specified under "SetPlayerSkillLevel"
Parameters:
playerid = the player to get the skill level.
weapontype = the skill of the weapontype to get.

Returns = -1 if player isn't connected, 0 if weapontype is not supported in "SetPlayerSkillLevel", skill value if it's done well.
*/

stock GetPlayerSkillLevel(playerid, weapontype)
{
 if(!IsPlayerConnected(playerid)) return -1;
 switch(weapontype)
 {
  case WEAPONSKILL_PISTOL: return LS::DefaultSkill[playerid][LS::WEAPONSKILL_PISTOL];
  case WEAPONSKILL_PISTOL_SILENCED: return LS::DefaultSkill[playerid][LS::WEAPONSKILL_SPISTOL];
  case WEAPONSKILL_DESERT_EAGLE: return LS::DefaultSkill[playerid][LS::WEAPONSKILL_DESERT_EAGLE];
  case WEAPONSKILL_SHOTGUN: return LS::DefaultSkill[playerid][LS::WEAPONSKILL_SHOTGUN];
  case WEAPONSKILL_SAWNOFF_SHOTGUN: return LS::DefaultSkill[playerid][LS::WEAPONSKILL_SAWNOFF];
  case WEAPONSKILL_SPAS12_SHOTGUN: return LS::DefaultSkill[playerid][LS::WEAPONSKILL_SPAS12];
  case WEAPONSKILL_MICRO_UZI: return LS::DefaultSkill[playerid][LS::WEAPONSKILL_MICRO_UZI];
  case WEAPONSKILL_MP5: return LS::DefaultSkill[playerid][LS::WEAPONSKILL_MP5];
  case WEAPONSKILL_AK47: return LS::DefaultSkill[playerid][LS::WEAPONSKILL_AK47];
  case WEAPONSKILL_M4: return LS::DefaultSkill[playerid][LS::WEAPONSKILL_M4];
  case WEAPONSKILL_SNIPERRIFLE: return LS::DefaultSkill[playerid][LS::WEAPONSKILL_SNIPERRIFLE];
  default: { printf("L_Skills : Invalid weapontype parameter used in GetPlayerSkillLevel!"); return -2; }
 }
 return 1;
}

/*Hooked "SetPlayerSkillLevel" to make it compatible with GetPlayerSkillLevel as it's not server sided, its DEFAULT
SA-MP weapon skill of a player.*/

stock LS::SetPlayerSkill(playerid, weapontype, skill)
{
 if(!IsPlayerConnected(playerid)) return -1;
 switch(weapontype)
 {
  case WEAPONSKILL_PISTOL:
  {
   SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, skill);
   LS::DefaultSkill[playerid][LS::WEAPONSKILL_PISTOL] = skill;
  }
  case WEAPONSKILL_PISTOL_SILENCED:
  {
   SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, skill);
   LS::DefaultSkill[playerid][LS::WEAPONSKILL_SPISTOL] = skill;
  }
  case WEAPONSKILL_DESERT_EAGLE:
  {
   SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, skill);
   LS::DefaultSkill[playerid][LS::WEAPONSKILL_DESERT_EAGLE] = skill;
  }
  case WEAPONSKILL_SHOTGUN:
  {
   SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, skill);
   LS::DefaultSkill[playerid][LS::WEAPONSKILL_SHOTGUN] = skill;
  }
  case WEAPONSKILL_SWANOFF_SHOTGUN:
  {
   SetPlayerSkillLevel(playerid, WEAPONSKILL_SWANOFF_SHOTGUN, skill);
   LS::DefaultSkill[playerid][LS::WEAPONSKILL_SAWNOFF] = skill;
  }
  case WEAPONSKILL_SPAS12_SHOTGUN:
  {
   SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, skill);
   LS::DefaultSkill[playerid][LS::WEAPONSKILL_SPAS12] = skill;
  }
  case WEAPONSKILL_MICRO_UZI:
  {
   SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, skill);
   LS::DefaultSkill[playerid][LS::WEAPONSKILL_MICRO_UZI] = skill;
  }
  case WEAPONSKILL_MP5:
  {
   SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, skill);
   LS::DefaultSkill[playerid][LS::WEAPONSKILL_MP5] = skill;
  }
  case WEAPONSKILL_AK47:
  {
   SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, skill);
   LS::DefaultSkill[playerid][LS::WEAPONSKILL_AK47] = skill;
  }
  case WEAPONSKILL_M4:
  {
   SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, skill);
   LS::DefaultSkill[playerid][LS::WEAPONSKILL_M4] = skill;
  }
  case WEAPONSKILL_SNIPERRIFLE:
  {
   SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE, skill);
   LS::DefaultSkill[playerid][LS::WEAPONSKILL_SNIPERRIFLE] = skill;
  }
  default : { printf("L_Skills: Couldn't apply skill as the weapontype is INVALID!\nFunction: SetPlayerSkillLevel"); return 0; }
 }
 return 1;
}

/*
Function : GetPlayerWeaponSkill
How does it work: It returns the skill level of the player's weapon.
Parameters:
playerid = the player the function performs.
weaponid = specified weapon's skill on the player.

Returns = -1 if playerid isn't connected, -2 if weaponid isn't supported in this function, skill value if it's done well.*/

stock GetPlayerWeaponSkill(playerid, weaponid)
{
 if(!IsPlayerConnected(playerid)) return -1;
 switch(weaponid)
 {
  case 0: return LS::SkillInfo[playerid][LS::Fist];
  case 1: return LS::SkillInfo[playerid][LS::Knuckles];
  case 2: return LS::SkillInfo[playerid][LS::Golf];
  case 3: return LS::SkillInfo[playerid][LS::Night];
  case 4: return LS::SkillInfo[playerid][LS::Knife];
  case 5: return LS::SkillInfo[playerid][LS::Bat];
  case 6: return LS::SkillInfo[playerid][LS::Shovel];
  case 7: return LS::SkillInfo[playerid][LS::Pool];
  case 8: return LS::SkillInfo[playerid][LS::Katana];
  case 9: return LS::SkillInfo[playerid][LS::Chainsaw];
  case 10: return LS::SkillInfo[playerid][LS::Dildo];
  case 11: return LS::SkillInfo[playerid][LS::Dildo2];
  case 12: return LS::SkillInfo[playerid][LS::Vibrator];
  case 13: return LS::SkillInfo[playerid][LS::Vibrator2];
  case 14: return LS::SkillInfo[playerid][LS::Flower];
  case 15: return LS::SkillInfo[playerid][LS::Cane];
  case 16: return LS::SkillInfo[playerid][LS::Grenade];
  case 22: return LS::SkillInfo[playerid][LS::Pistol];
  case 23: return LS::SkillInfo[playerid][LS::Silenced];
  case 24: return LS::SkillInfo[playerid][LS::Deagle];
  case 25: return LS::SkillInfo[playerid][LS::Shotgun];
  case 26: return LS::SkillInfo[playerid][LS::Swanoff];
  case 27: return LS::SkillInfo[playerid][LS::Combat];
  case 28: return LS::SkillInfo[playerid][LS::Uzi];
  case 29: return LS::SkillInfo[playerid][LS::Mp5];
  case 30: return LS::SkillInfo[playerid][LS::AK47];
  case 31: return LS::SkillInfo[playerid][LS::M4];
  case 32: return LS::SkillInfo[playerid][LS::Tec];
  case 33: return LS::SkillInfo[playerid][LS::Rifle];
  case 34: return LS::SkillInfo[playerid][LS::Sniper];
  case 35: return LS::SkillInfo[playerid][LS::RPG];
  case 36: return LS::SkillInfo[playerid][LS::HS];
  case 38: return LS::SkillInfo[playerid][LS::Minigun];
  case 41: return LS::SkillInfo[playerid][LS::Spray];
  case 42: return LS::SkillInfo[playerid][LS::FireEx];
  default: { printf("L_Skills.inc: Insufficient weaponid used on 'GetPlayerWeaponSkill'. \nPlease use valid weaponids of that function only."); return -2; }
 }
 return 1;
}

/*
Function : SetPlayerWeaponSkill
How does it work: It sets the server sided weapon skill of a weapon for particular player.
Parameters:
playerid = the player in which the function performs.
weaponid = the weapon in which the skill must be set for the player.

Returns = -1 if player isn't connected, 0 if invalid weaponid for this function, 1 if it sets well.*/

stock SetPlayerWeaponSkill(playerid, weaponid, skill)
{
 if(!IsPlayerConnected(playerid)) return -1;
 if(skill > 999) skill = 999;
 switch(weaponid)
 {
  case 0: return LS::SkillInfo[playerid][LS::Fist] = skill;
  case 1: return LS::SkillInfo[playerid][LS::Knuckles] = skill;
  case 2: return LS::SkillInfo[playerid][LS::Golf] = skill;
  case 3: return LS::SkillInfo[playerid][LS::Night] = skill;
  case 4: return LS::SkillInfo[playerid][LS::Knife] = skill;
  case 5: return LS::SkillInfo[playerid][LS::Bat] = skill;
  case 6: return LS::SkillInfo[playerid][LS::Shovel] = skill;
  case 7: return LS::SkillInfo[playerid][LS::Pool] = skill;
  case 8: return LS::SkillInfo[playerid][LS::Katana] = skill;
  case 9: return LS::SkillInfo[playerid][LS::Chainsaw] = skill;
  case 10: return LS::SkillInfo[playerid][LS::Dildo] = skill;
  case 11: return LS::SkillInfo[playerid][LS::Dildo2] = skill;
  case 12: return LS::SkillInfo[playerid][LS::Vibrator] = skill;
  case 13: return LS::SkillInfo[playerid][LS::Vibrator2] = skill;
  case 14: return LS::SkillInfo[playerid][LS::Flower] = skill;
  case 15: return LS::SkillInfo[playerid][LS::Cane] = skill;
  case 16: return LS::SkillInfo[playerid][LS::Grenade] = skill;
  case 22: return LS::SkillInfo[playerid][LS::Pistol] = skill;
  case 23: return LS::SkillInfo[playerid][LS::Silenced] = skill;
  case 24: return LS::SkillInfo[playerid][LS::Deagle] = skill;
  case 25: return LS::SkillInfo[playerid][LS::Shotgun] = skill;
  case 26: return LS::SkillInfo[playerid][LS::Swanoff] = skill;
  case 27: return LS::SkillInfo[playerid][LS::Combat] = skill;
  case 28: return LS::SkillInfo[playerid][LS::Uzi] = skill;
  case 29: return LS::SkillInfo[playerid][LS::Mp5] = skill;
  case 30: return LS::SkillInfo[playerid][LS::AK47] = skill;
  case 31: return LS::SkillInfo[playerid][LS::M4] = skill;
  case 32: return LS::SkillInfo[playerid][LS::Tec] = skill;
  case 33: return LS::SkillInfo[playerid][LS::Rifle] = skill;
  case 34: return LS::SkillInfo[playerid][LS::Sniper] = skill;
  case 35: return LS::SkillInfo[playerid][LS::RPG] = skill;
  case 36: return LS::SkillInfo[playerid][LS::HS] = skill;
  case 38: return LS::SkillInfo[playerid][LS::Minigun] = skill;
  case 41: return LS::SkillInfo[playerid][LS::Spray] = skill;
  case 42: return LS::SkillInfo[playerid][LS::FireEx] = skill;
  default: { printf("L_Skills: Insufficient weaponid given in 'SetPlayerWeaponSkill'.\nPlease use a weaponid which supports this function!"); return 0; }
 }
 CallLocalFunction("OnWeaponSkillLevelSet", "iii", playerid, weaponid, skill);
 return 1;
}

/*
Function: TogglePlayerWeaponSkill
How it works: It toggles the server sided weapon skill of a player either as true(enabled) or as false(disabled).
Parameters:
playerid = the player in which the function performs.
bool:weapon_skill = set the weapon_skill to true if to enable, or else to false to disable.

Returns = it doesn't return any specified value.
*/

stock TogglePlayerWeaponSkill(playerid, bool:weapon_skill)
{
 return LS::SkillInfo[playerid][LS::Enabled] = weapon_skill;
}

/*
Function: DisablePlayerWeaponSkill
How it works: It disables the server sided weapon skill from a player.
Parameters:
playerid = the player in which the function performs.

Returns = No specified values.
*/
stock DisablePlayerWeaponSkill(playerid)
{
 return LS::SkillInfo[playerid][LS::Enabled] = 0;
}

/*
Function: EnablePlayerWeaponSkill
How it works: It enables the server sided weapon skill from a player.
Parameters:
playerid = the player in which the function performs.

Returns = No specified values.
*/

stock EnablePlayerWeaponSkill(playerid)
{
 return LS::SkillInfo[playerid][LS::Enabled] = 1;
}

/*
Function: IsPlayerWeaponSkillEnabled
How it works: It detects if player's server sided weapon skill is enabled or not.
Parameters:
playerid = the player in which the function performs.

Returns  = 1 if enabled, 0 if disabled.
*/

stock IsPlayerWeaponSkillEnabled(playerid)
{
 if(LS::SkillInfo[playerid][LS::Enabled] == 1) return true;
 else return false;
}

stock GetWeaponDamageRate(weaponid)
{
 if(!IsWeaponValidForLSkills(weaponid)) return -1;
 switch(weaponid) {
 case 2: return WEAPON_DAMAGE_GOLF;
 case 3: return WEAPON_DAMAGE_NIGHT;
 case 4: return WEAPON_DAMAGE_KNIFE;
 case 5: return WEAPON_DAMAGE_BAT;
 case 6: return WEAPON_DAMAGE_SHOVEL;
 case 7: return WEAPON_DAMAGE_POOL;
 case 8: return WEAPON_DAMAGE_KATANA;
 case 9: return WEAPON_DAMAGE_CHAINSAW;
 case 10: return WEAPON_DAMAGE_DILDO;
 case 11: return WEAPON_DAMAGE_DILDO2;
 case 12: return WEAPON_DAMAGE_VIBRATOR;
 case 13: return WEAPON_DAMAGE_VIBRATOR2;
 case 14: return WEAPON_DAMAGE_FLOWER;
 case 15: return WEAPON_DAMAGE_CANE;
 case 16: return WEAPON_DAMAGE_GRENADE;
 case 22: return WEAPON_DAMAGE_PISTOL;
 case 23: return WEAPON_DAMAGE_SILENCED;
 case 24: return WEAPON_DAMAGE_DEAGLE;
 case 25: return WEAPON_DAMAGE_SHOTGUN;
 case 26: return WEAPON_DAMAGE_SWANOFF;
 case 27: return WEAPON_DAMAGE_COMBAT;
 case 28: return WEAPON_DAMAGE_UZI;
 case 29: return WEAPON_DAMAGE_MP5;
 case 30: return WEAPON_DAMAGE_AK47;
 case 31: return WEAPON_DAMAGE_M4;
 case 32: return WEAPON_DAMAGE_TEC;
 case 33: return WEAPON_DAMAGE_RIFLE;
 case 34: return WEAPON_DAMAGE_SNIPER;
 case 35: return WEAPON_DAMAGE_RPG;
 case 36: return WEAPON_DAMAGE_HS;
 case 38: return WEAPON_DAMAGE_MINIGUN;
 case 41: return WEAPON_DAMAGE_SPRAY;
 case 42: return WEAPON_DAMAGE_FIREEX;
 }
 return 1;
}


//This function is just for the support of this include.
stock IsWeaponValidForLSkills(weaponid)
{
 switch(weaponid)
 {
  case 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,38,41,42: return true;
  default: return false;
 }
 return 1;
}

#if defined _ALS_SetPlayerSkillLevel
 #undef SetPlayerSkillLevel
#else
 #define _ALS_SetPlayerSkillLevel
#endif

#define SetPlayerSkillLevel LS::SetPlayerSkill

#if defined FILTERSCRIPT
public OnFilterScriptInit()
{
 SetTimer("LSkills_Timer1", 400, true);
 CallLocalFunction("LSkills_OnFS", "");
 return 1;
}

forward LSkills_OnFS();
 #if defined _ALS_OnFilterScriptInit
  #undef OnFilterScriptInit
 #else
  #define _ALS_OnFilterScriptInit
 #endif

#define OnFilterScriptInit LSkills_OnFS

#else

public OnGameModeInit()
{
 SetTimer("LSkills_Timer1", 400, true);
 CallLocalFunction("LSkills_OnGM", "");
 return 1;
}

forward LSkills_OnGM();
 #if defined _ALS_OnGameModeInit
  #undef OnGameModeInit
 #else
  #define _ALS_OnGameModeInit
 #endif

#define OnGameModeInit LSkills_OnGM

#endif

forward LSkills_Timer1();
public LSkills_Timer1()
{
 new _tick = GetTickCount();
 for(new i; i< GetMaxPlayers(); i++)
 {
  if(!IsPlayerConnected(i)) continue;
  #if defined USE_LSKILLS_ANTICHEAT
   for(new s=0; s< 11; s++)
   {
	SetPlayerSkillLevel(i, s, GetPlayerSkillLevel(i,s));
   }
  #endif
  if(LS::p_Nocall[i] != 0) continue;
  if(LS::p_Spawned[i] != 1) continue;
  if((_tick - LS::p_OldTicks[i]) >= 4500)
  {
   if(GetPlayerState(i) >= 1 && GetPlayerState(i) <= 3)
   {
	LS::p_Nocall[i] = 1;
   }
  }
 }
 return 1;
}

public OnPlayerUpdate(playerid)
{
 LS::p_OldTicks[playerid] = GetTickCount();
 if(LS::p_Nocall[playerid] == 1)
 {
  LS::p_Nocall[playerid] = 0;
 }
 CallLocalFunction("LSkills_OnPlayerUpdate", "i", playerid);
 return 1;
}

#if defined _ALS_OnPlayerUpdate
 #undef OnPlayerUpdate
#else
 #define _ALS_OnPlayerUpdate
#endif

forward LSkills_OnPlayerUpdate(playerid);

#define OnPlayerUpdate LSkills_OnPlayerUpdate


public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid)
{
 if(LS::p_Nocall[damagedid] == 1) return 0;
 if(IsPlayerWeaponSkillEnabled(damagedid))
 {
  if(IsWeaponValidForLSkills(weaponid))
  {
   new accuracy = GetPlayerWeaponSkill(playerid, weaponid);
   if(accuracy < 10) return 0;
   if(accuracy > MAX_WEAPON_SKILL)
   {
	SetPlayerWeaponSkill(playerid, weaponid, MAX_WEAPON_SKILL);
	accuracy = MAX_WEAPON_SKILL;
   }
   new final = accuracy/10;
   DamagePlayer(damagedid, float(final)); //Damages player more!
  }
 }
 CallLocalFunction("LSkill_OnPlayerGiveDamage", "iifi", playerid, damagedid, amount, weaponid);
 return 1;
}

forward OnWeaponSkillLevelSet(playerid, weaponid, skill);


#if defined APPLY_DEFAULT_SKILL
public OnWeaponSkillLevelSet(playerid, weaponid, skill)
{
 new oskill = skill;
 if(skill >= 1000)
 {
  skill = 999;
 }
 switch(weaponid)
 {
  case 22: return SetPlayerSkillLevel(playerid, 0, skill);
  case 23: return SetPlayerSkillLevel(playerid, 1, skill);
  case 24: return SetPlayerSkillLevel(playerid, 2, skill);
  case 25: return SetPlayerSkillLevel(playerid, 3, skill);
  case 26: return SetPlayerSkillLevel(playerid, 4, skill);
  case 27: return SetPlayerSkillLevel(playerid, 5, skill);
  case 28,32: return SetPlayerSkillLevel(playerid, 6, skill);
  case 29: return SetPlayerSkillLevel(playerid, 7, skill);
  case 30: return SetPlayerSkillLevel(playerid, 8, skill);
  case 31: return SetPlayerSkillLevel(playerid, 9, skill);
  case 34: return SetPlayerSkillLevel(playerid, 10, skill);
 }
 CallLocalFunction("LSkill_OWSLS", "iii", playerid, weaponid, oskill);
 return 1;
}

#if defined _ALS_OnWeaponSkillLevelSet
 #undef OnWeaponSkillLevelSet
#else
 #define _ALS_OnWeaponSkillLevelSet
#endif

#define OnWeaponSkillLevelSet LSkill_OWSLS

forward OnWeaponSkillLevelSet(playerid, weaponid, skill);

#endif

#if defined _ALS_OnPlayerGiveDamage
 #undef OnPlayerGiveDamage
#else
 #define _ALS_OnPlayerGiveDamage
#endif

#define OnPlayerGiveDamage LSkill_OnPlayerGiveDamage

forward LSkill_OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid);


public OnPlayerConnect(playerid)
{
 for(new i; i< 11; i++)
 {
  SetPlayerSkillLevel(playerid, i, 0); //Resets the skill.
 }
 for(new i; i< 42; i++)
 {
  if(i >= 17 && i <= 21) continue;
  if(i == 37 || i == 39 || i == 40) continue;
  SetPlayerWeaponSkill(playerid, i, 0);
 }
 TogglePlayerWeaponSkill(playerid, false);
 LS::p_Nocall[playerid] = 0;
 LS::p_Spawned[playerid] = 0;
 CallLocalFunction("LSkill_OPC", "i", playerid);
 return 1;
}

#if defined _ALS_OnPlayerConnect
 #undef OnPlayerConnect
#else
 #define _ALS_OnPlayerConnect
#endif

#define OnPlayerConnect LSkill_OPC

public OnPlayerSpawn(playerid)
{
 LS::p_Spawned[playerid] = 1;
 CallLocalFunction("LSkills_OnPlayerSpawn", "i", playerid);
 return 1;
}

#if defined _ALS_OnPlayerSpawn
 #undef OnPlayerSpawn
#else
 #define _ALS_OnPlayerSpawn
#endif

forward LSkills_OnPlayerSpawn(playerid);

#define OnPlayerSpawn LSkills_OnPlayerSpawn


public OnPlayerDeath(playerid, killerid, reason)
{
 LS::p_Spawned[playerid] = 0;
 CallLocalFunction("LSkills_OnPlayerDeath", "iii", playerid, killerid, reason);
 return 1;
}

#if defined _ALS_OnPlayerDeath
 #undef OnPlayerDeath
#else
 #define _ALS_OnPlayerDeath
#endif

forward LSkills_OnPlayerDeath(playerid, killerid, reason);

#define OnPlayerDeath LSkills_OnPlayerDeath

forward LSkill_OPC(playerid);