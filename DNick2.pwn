#include <a_samp>
// for the samp stuff
#include <dutils>
// for the functions dini and dudb need
#include <dudb>
// ste.inc
//#include <ste>
// for the userdatabase, get dudb version 1.2 for this.
#define dcmd(%1,%2,%3) if ((strcmp(%3, "/%1", true, %2+1) == 0)&&(((%3[%2+1]==0)&&(dcmd_%1(playerid,"")))||((%3[%2+1]==32)&&(dcmd_%1(playerid,%3[%2+2]))))) return 1;
#define COLOR_SYSTEM 0xEFEFF7AA
//authorize timeout
#define AUTH_TIMEOUT 60000
#define NOTIFY_TIME 10000
#define NOTIFY_TIMEOUT 15000

new PLAYERLIST_authed[MAX_PLAYERS];
//player timer ids
new PLAYERLIST_timer[MAX_PLAYERS];



public SystemMsg(playerid,msg[]) {
   if ((IsPlayerConnected(playerid))&&(strlen(msg)>0)) {
       SendClientMessage(playerid,COLOR_SYSTEM,msg);
   }
   return 1;
}

public OnPlayerCommandText(playerid,cmdtext[]) {
  dcmd(login,5,cmdtext) // because login has 5 characters
  dcmd(register,8,cmdtext) // because register has 8 characters
  return false;
}

public OnPlayerConnect(playerid) {
  	PLAYERLIST_authed[playerid]=false;
    //have account?
	if(udb_Exists(PlayerName(playerid))){
	    new str[50];
	    printf("Uzivatel %s loged, and have account, must register.",PlayerName(playerid));

		SystemMsg(playerid,"Tento uzivatel ma zde ucet, prihlaste se do 60ti vterin,nebo budete vyhozeni! (/login pass)");
		format(str,sizeof(str),"TIPL_%i",playerid);
		PLAYERLIST_timer[playerid] = SetTimer(str,AUTH_TIMEOUT,0);
		format(str,sizeof(str),"TNOT_%i",playerid);
		SetTimer(str,NOTIFY_TIME,0);
	}
	else{
		printf("Uzivatel %s loged, and have no account.",PlayerName(playerid));
	    SystemMsg(playerid,"You can register /register pass");
	}
	return true;
}

//optimize this
public TNOT_0(){TimerNotify(0);}
public TNOT_1(){TimerNotify(1);}
public TNOT_2(){TimerNotify(2);}
public TNOT_3(){TimerNotify(3);}
public TNOT_4(){TimerNotify(4);}
public TNOT_5(){TimerNotify(5);}
public TNOT_6(){TimerNotify(6);}
public TNOT_7(){TimerNotify(7);}
public TNOT_8(){TimerNotify(8);}
public TNOT_9(){TimerNotify(9);}
public TNOT_10(){TimerNotify(10);}
public TNOT_11(){TimerNotify(11);}
public TNOT_12(){TimerNotify(12);}
public TNOT_13(){TimerNotify(13);}
public TNOT_14(){TimerNotify(14);}
public TNOT_15(){TimerNotify(15);}
public TNOT_16(){TimerNotify(16);}
public TNOT_17(){TimerNotify(17);}
public TNOT_18(){TimerNotify(18);}
public TNOT_19(){TimerNotify(19);}
public TNOT_20(){TimerNotify(20);}
public TNOT_21(){TimerNotify(21);}
public TNOT_22(){TimerNotify(22);}
public TNOT_23(){TimerNotify(23);}
public TNOT_24(){TimerNotify(24);}
public TNOT_25(){TimerNotify(25);}
public TNOT_26(){TimerNotify(26);}
public TNOT_27(){TimerNotify(27);}
public TNOT_28(){TimerNotify(28);}
public TNOT_29(){TimerNotify(29);}
public TNOT_30(){TimerNotify(30);}
public TNOT_31(){TimerNotify(31);}
public TNOT_32(){TimerNotify(32);}
public TNOT_33(){TimerNotify(33);}
public TNOT_34(){TimerNotify(34);}
public TNOT_35(){TimerNotify(35);}
public TNOT_36(){TimerNotify(36);}
public TNOT_37(){TimerNotify(37);}
public TNOT_38(){TimerNotify(38);}
public TNOT_39(){TimerNotify(39);}
public TNOT_40(){TimerNotify(40);}
public TNOT_41(){TimerNotify(41);}
public TNOT_42(){TimerNotify(42);}
public TNOT_43(){TimerNotify(43);}
public TNOT_44(){TimerNotify(44);}
public TNOT_45(){TimerNotify(45);}
public TNOT_46(){TimerNotify(46);}
public TNOT_47(){TimerNotify(47);}
public TNOT_48(){TimerNotify(48);}
public TNOT_49(){TimerNotify(49);}
public TNOT_50(){TimerNotify(50);}
public TNOT_51(){TimerNotify(51);}
public TNOT_52(){TimerNotify(52);}
public TNOT_53(){TimerNotify(53);}
public TNOT_54(){TimerNotify(54);}
public TNOT_55(){TimerNotify(55);}
public TNOT_56(){TimerNotify(56);}
public TNOT_57(){TimerNotify(57);}
public TNOT_58(){TimerNotify(58);}
public TNOT_59(){TimerNotify(59);}
public TNOT_60(){TimerNotify(60);}
public TNOT_61(){TimerNotify(61);}
public TNOT_62(){TimerNotify(62);}
public TNOT_63(){TimerNotify(63);}
public TNOT_64(){TimerNotify(64);}
public TNOT_65(){TimerNotify(65);}
public TNOT_66(){TimerNotify(66);}
public TNOT_67(){TimerNotify(67);}
public TNOT_68(){TimerNotify(68);}
public TNOT_69(){TimerNotify(69);}
public TNOT_70(){TimerNotify(70);}
public TNOT_71(){TimerNotify(71);}
public TNOT_72(){TimerNotify(72);}
public TNOT_73(){TimerNotify(73);}
public TNOT_74(){TimerNotify(74);}
public TNOT_75(){TimerNotify(75);}
public TNOT_76(){TimerNotify(76);}
public TNOT_77(){TimerNotify(77);}
public TNOT_78(){TimerNotify(78);}
public TNOT_79(){TimerNotify(79);}
public TNOT_80(){TimerNotify(80);}
public TNOT_81(){TimerNotify(81);}
public TNOT_82(){TimerNotify(82);}
public TNOT_83(){TimerNotify(83);}
public TNOT_84(){TimerNotify(84);}
public TNOT_85(){TimerNotify(85);}
public TNOT_86(){TimerNotify(86);}
public TNOT_87(){TimerNotify(87);}
public TNOT_88(){TimerNotify(88);}
public TNOT_89(){TimerNotify(89);}
public TNOT_90(){TimerNotify(90);}
public TNOT_91(){TimerNotify(91);}
public TNOT_92(){TimerNotify(92);}
public TNOT_93(){TimerNotify(93);}
public TNOT_94(){TimerNotify(94);}
public TNOT_95(){TimerNotify(95);}
public TNOT_96(){TimerNotify(96);}
public TNOT_97(){TimerNotify(97);}
public TNOT_98(){TimerNotify(98);}
public TNOT_99(){TimerNotify(99);}


public TIPL_0(){TimerIsPlayerLoged(0);}
public TIPL_1(){TimerIsPlayerLoged(1);}
public TIPL_2(){TimerIsPlayerLoged(2);}
public TIPL_3(){TimerIsPlayerLoged(3);}
public TIPL_4(){TimerIsPlayerLoged(4);}
public TIPL_5(){TimerIsPlayerLoged(5);}
public TIPL_6(){TimerIsPlayerLoged(6);}
public TIPL_7(){TimerIsPlayerLoged(7);}
public TIPL_8(){TimerIsPlayerLoged(8);}
public TIPL_9(){TimerIsPlayerLoged(9);}
public TIPL_10(){TimerIsPlayerLoged(10);}
public TIPL_11(){TimerIsPlayerLoged(11);}
public TIPL_12(){TimerIsPlayerLoged(12);}
public TIPL_13(){TimerIsPlayerLoged(13);}
public TIPL_14(){TimerIsPlayerLoged(14);}
public TIPL_15(){TimerIsPlayerLoged(15);}
public TIPL_16(){TimerIsPlayerLoged(16);}
public TIPL_17(){TimerIsPlayerLoged(17);}
public TIPL_18(){TimerIsPlayerLoged(18);}
public TIPL_19(){TimerIsPlayerLoged(19);}
public TIPL_20(){TimerIsPlayerLoged(20);}
public TIPL_21(){TimerIsPlayerLoged(21);}
public TIPL_22(){TimerIsPlayerLoged(22);}
public TIPL_23(){TimerIsPlayerLoged(23);}
public TIPL_24(){TimerIsPlayerLoged(24);}
public TIPL_25(){TimerIsPlayerLoged(25);}
public TIPL_26(){TimerIsPlayerLoged(26);}
public TIPL_27(){TimerIsPlayerLoged(27);}
public TIPL_28(){TimerIsPlayerLoged(28);}
public TIPL_29(){TimerIsPlayerLoged(29);}
public TIPL_30(){TimerIsPlayerLoged(30);}
public TIPL_31(){TimerIsPlayerLoged(31);}
public TIPL_32(){TimerIsPlayerLoged(32);}
public TIPL_33(){TimerIsPlayerLoged(33);}
public TIPL_34(){TimerIsPlayerLoged(34);}
public TIPL_35(){TimerIsPlayerLoged(35);}
public TIPL_36(){TimerIsPlayerLoged(36);}
public TIPL_37(){TimerIsPlayerLoged(37);}
public TIPL_38(){TimerIsPlayerLoged(38);}
public TIPL_39(){TimerIsPlayerLoged(39);}
public TIPL_40(){TimerIsPlayerLoged(40);}
public TIPL_41(){TimerIsPlayerLoged(41);}
public TIPL_42(){TimerIsPlayerLoged(42);}
public TIPL_43(){TimerIsPlayerLoged(43);}
public TIPL_44(){TimerIsPlayerLoged(44);}
public TIPL_45(){TimerIsPlayerLoged(45);}
public TIPL_46(){TimerIsPlayerLoged(46);}
public TIPL_47(){TimerIsPlayerLoged(47);}
public TIPL_48(){TimerIsPlayerLoged(48);}
public TIPL_49(){TimerIsPlayerLoged(49);}
public TIPL_50(){TimerIsPlayerLoged(50);}
public TIPL_51(){TimerIsPlayerLoged(51);}
public TIPL_52(){TimerIsPlayerLoged(52);}
public TIPL_53(){TimerIsPlayerLoged(53);}
public TIPL_54(){TimerIsPlayerLoged(54);}
public TIPL_55(){TimerIsPlayerLoged(55);}
public TIPL_56(){TimerIsPlayerLoged(56);}
public TIPL_57(){TimerIsPlayerLoged(57);}
public TIPL_58(){TimerIsPlayerLoged(58);}
public TIPL_59(){TimerIsPlayerLoged(59);}
public TIPL_60(){TimerIsPlayerLoged(60);}
public TIPL_61(){TimerIsPlayerLoged(61);}
public TIPL_62(){TimerIsPlayerLoged(62);}
public TIPL_63(){TimerIsPlayerLoged(63);}
public TIPL_64(){TimerIsPlayerLoged(64);}
public TIPL_65(){TimerIsPlayerLoged(65);}
public TIPL_66(){TimerIsPlayerLoged(66);}
public TIPL_67(){TimerIsPlayerLoged(67);}
public TIPL_68(){TimerIsPlayerLoged(68);}
public TIPL_69(){TimerIsPlayerLoged(69);}
public TIPL_70(){TimerIsPlayerLoged(70);}
public TIPL_71(){TimerIsPlayerLoged(71);}
public TIPL_72(){TimerIsPlayerLoged(72);}
public TIPL_73(){TimerIsPlayerLoged(73);}
public TIPL_74(){TimerIsPlayerLoged(74);}
public TIPL_75(){TimerIsPlayerLoged(75);}
public TIPL_76(){TimerIsPlayerLoged(76);}
public TIPL_77(){TimerIsPlayerLoged(77);}
public TIPL_78(){TimerIsPlayerLoged(78);}
public TIPL_79(){TimerIsPlayerLoged(79);}
public TIPL_80(){TimerIsPlayerLoged(80);}
public TIPL_81(){TimerIsPlayerLoged(81);}
public TIPL_82(){TimerIsPlayerLoged(82);}
public TIPL_83(){TimerIsPlayerLoged(83);}
public TIPL_84(){TimerIsPlayerLoged(84);}
public TIPL_85(){TimerIsPlayerLoged(85);}
public TIPL_86(){TimerIsPlayerLoged(86);}
public TIPL_87(){TimerIsPlayerLoged(87);}
public TIPL_88(){TimerIsPlayerLoged(88);}
public TIPL_89(){TimerIsPlayerLoged(89);}
public TIPL_90(){TimerIsPlayerLoged(90);}
public TIPL_91(){TimerIsPlayerLoged(91);}
public TIPL_92(){TimerIsPlayerLoged(92);}
public TIPL_93(){TimerIsPlayerLoged(93);}
public TIPL_94(){TimerIsPlayerLoged(94);}
public TIPL_95(){TimerIsPlayerLoged(95);}
public TIPL_96(){TimerIsPlayerLoged(96);}
public TIPL_97(){TimerIsPlayerLoged(97);}
public TIPL_98(){TimerIsPlayerLoged(98);}
public TIPL_99(){TimerIsPlayerLoged(99);}



public TimerIsPlayerLoged(playerid){
	new str[256];
	if(!IsPlayerConnected(playerid))
	    return;
	if(PLAYERLIST_authed[playerid]){
	    printf("Uzivatel %s prosel 60vterinovou autorizaci.",PlayerName(playerid));
	    SystemMsg(COLOR_SYSTEM,"Byl jsi uspesne autorizovan!");
	    GameTextForPlayer(playerid,"~G~Byl jsi uspesne autorizovan!",5000,1);
	}
	else{
	    printf("Uzivatel %s neprosel 60vterinovou autorizaci(vykopnut).",PlayerName(playerid));
		format(str,sizeof(str),"Uzivatel %s nebyl autorizovan proto byl vykopnut!",PlayerName(playerid));
		SendClientMessageToAll(COLOR_SYSTEM,str);
		Kick(playerid);
	}
}

public TimerNotify(playerid){
	if(!IsPlayerConnected(playerid))
	    return;
    printf("Uzivatel %s upozornen na autorizaci.",PlayerName(playerid));
 	SystemMsg(playerid,"Tento uzivatel ma zde ucet, prihlaste se do 60ti vterin,nebo budete vyhozeni! (/login pass)");
	GameTextForPlayer(playerid,"~R~Tento uzivatel ma zde ucet, prihlaste se do 60ti vterin,nebo budete vyhozeni! (/login pass)",NOTIFY_TIMEOUT,1);
}

public OnPlayerDisconnect(playerid) {
  if (PLAYERLIST_authed[playerid]) {
     // Was loggedin, so save the data!
     udb_setAccState(PlayerName(playerid),GetPlayerMoney(playerid));
	 
  }
  //kill timer
  printf("Uzivatel %s disconnect.",PlayerName(playerid));
  KillTimer(PLAYERLIST_timer[playerid]);
  return false;
}
/*
 * This function will be useful when we need the playername
 * (c) by DracoBlue 2006
 */
public PlayerName(playerid) {
  new name[MAX_PLAYER_NAME];
  GetPlayerName(playerid, name, MAX_PLAYER_NAME);
  return name;
}



/*
 *  /register password
 *
 */
  dcmd_register(playerid,params[]) {

    // The command shouldn't work if we already are authed
    if (PLAYERLIST_authed[playerid]) return SystemMsg(playerid,"Already authed.");

    // The command shouldn't work if an account with this
    // nick already exists
    if (udb_Exists(PlayerName(playerid))) return SystemMsg(playerid,"Account already exists, please use '/login password'.");

    // Did he forgot the password?
    if (strlen(params)==0) return SystemMsg(playerid,"Correct usage: '/register password'");

    // We save the money to the accstate
    if (udb_Create(PlayerName(playerid),params,GetPlayerMoney(playerid),"")){
    	printf("Uzivatel %s byl registrovan.",PlayerName(playerid));
	 	return SystemMsg(playerid,"Account successfully created. Login with '/login password' now.");
	}
	return true;

 }

 /*
 *  /login password
 *
 */
  dcmd_login(playerid,params[]) {

    // The command shouldn't work if we already are authed
    if (PLAYERLIST_authed[playerid]) return SystemMsg(playerid,"Already authed.");

    // The command shouldn't work if an account with this
    // nick does not exists
    if (!udb_Exists(PlayerName(playerid))) return SystemMsg(playerid,"Account doesn't exist, please use '/register password'.");

    // Did he forgot the password?
    if (strlen(params)==0) return SystemMsg(playerid,"Correct usage: '/login password'");

    if (udb_CheckLogin(PlayerName(playerid),params)) {
       // Login was correct

       // Since we are using the "accstate"-variable to save and
       // read the money of the player, we can update his money now.

       // Following thing is the same like the missing SetPlayerCommand
       GivePlayerMoney(playerid,udb_getAccState(PlayerName(playerid))-GetPlayerMoney(playerid));

       PLAYERLIST_authed[playerid]=true;
        printf("Uzivatel %s autorizovan.",PlayerName(playerid));
       return SystemMsg(playerid,"Successfully authed!");
    } else {
       // Login was incorrect
       printf("Uzivatel %s spatna autorizace.",PlayerName(playerid));
       return SystemMsg(playerid,"Login failed!");
    }
    return true;
 }
 
 /*
 public STE_function_list(str[], num, func[])
{
func1(TimerIsPlayerLoged);
func0(Timer);
}*/
