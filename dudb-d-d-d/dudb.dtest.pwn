#include <a_samp>
#include <dtest>
#include <dudb>
/*
  This needs dtest 1.2, get it from
    http://dracoblue.com
*/

DTEST_SCRIPT_START("Read and Write Users for UserDB");
 
	dt_start("udb functions");
	dt_IsNot(udb_Remove("Neuer!23"),"udb_Remove(\"Neuer!23\")");
	dt_IsNot(udb_Remove("Neuer!23"),"udb_Remove(\"Neuer!23\")");
	dt_Is(udb_Create("Neuer!23","12314"),"udb_Create(\"Neuer!23\",\"12314\")");
	dt_Is(udb_CheckLogin("Neuer!23","12314"),"udb_CheckLogin(\"Neuer!23\",\"12314\")");
	dt_IsNot(udb_CheckLogin("Neuer!23","12315"),"udb_CheckLogin(\"Neuer!23\",\"12315\")");
	dt_IsNot(udb_Create("Neuer!23","12314"),"udb_Create(\"Neuer!23\",\"12314\")");
	dt_IsNot(udb_Remove("Nickname"),"udb_Remove(\"Nickname\")");
	dt_IsNot(udb_CheckLogin("Nickname","MyPwd"),"udb_Create(\"Nickname\",\"MyPwd\")");
	dt_IsNot(udb_Exists("Nickname"),"udb_Exists(\"Nickname\")");
	dt_Is(udb_Create("Nickname","MyPwd"),"udb_Create(\"Nickname\",\"MyPwd\")");
	dt_Is(udb_Exists("Nickname"),"udb_Exists(\"Nickname\")");
	dt_Is(udb_Exists("nickname"),"udb_Exists(\"nickname\")");
	dt_Is(udb_CheckLogin("Nickname","MyPwd"),"udb_Create(\"Nickname\",\"MyPwd\")");
	dt_Is(udb_Remove("Nickname"),"udb_Remove(\"Nickname\")");
	dt_IsNot(udb_CheckLogin("Nickname","MyPwd"),"udb_Create(\"Nickname\",\"MyPwd\")");
	dt_IsNot(udb_Remove("Nickname"),"udb_Remove(\"Nickname\")");
	dt_IsNot(udb_Exists("Nickname."),"udb_Exists(\"Nickname.\")");
	dt_IsNot(udb_Exists("Nickname"),"udb_Exists(\"Nickname\")");
	dt_IsNot(udb_Exists("nickname"),"udb_Exists(\"nickname\")");
	dt_IsNot(udb_Exists("nickname.2"),"udb_Exists(\"nickname.2\")");
	dt_end("udb functions");

	dt_start("udb_encode");
	dt_SSame(udb_decode(udb_encode("Hallo")),"Hallo","en and de code(\"Hallo\")");
	dt_SSame(udb_decode(udb_encode("Ha!_01&llo")),"Ha!_01&llo","en and de code(\"Ha!_01&llo\")");
	dt_SSame(udb_decode(udb_encode("!Ha!&llo&")),"!Ha!&llo&","en and de code(\"Ha!&llo&\")");
	dt_end("udb_encode");


	dt_start("dUserSet* & dUser*");
	dt_Is(udb_Create("Jan","12314"),"udb_Create(\"Jan\",\"12314\")");
	dt_Same(dUserINT("Jan").("password_hash"),udb_hash("12314"),"dUserINT(\"Jan\").(\"password_hash\")");
	dt_Is(dUserSet("Jan").("clantag","WmS"),"dUserSet(\"Jan\").(\"clantag\",\"WmS\")");
	dt_Is(dUserSet("Jan").("clantag","WmS2"),"dUserSet(\"Jan\").(\"clantag\",\"WmS2\")");
	dt_SSame(dUser("Jan").("clantag"),"WmS2","dUser(\"Jan\").(\"clantag\")");
	dt_Is(dUserSet("Jan").("clantag","WmS"),"dUserSet(\"Jan\").(\"clantag\",\"WmS\")");
	dt_IsNot(dUserSet("GibtEsNicht").("clantag","Huhu"),"dUserSet(\"GibtesNicht\").(\"clantag\",\"WmS\")");
	dt_SSame(dUser("Jan").("clantag"),"WmS","dUser(\"Jan\").(\"clantag\")");
	dt_SSame(dUser("Jan").("GibtesNicht"),"","dUser(\"Jan\").(\"GibtesNicht\")");
	dt_Is(udb_RenameUser("Jan","naJ"),"udb_RenameUser(\"Jan\",\"naJ\")");
	dt_Is(udb_Remove("naJ"),"udb_Remove(\"naJ\")");
	dt_end("dUserSet* & dUser*");

DTEST_SCRIPT_END

