#include <a_samp>
#include <dtest>
/* START: Functions to test : */
#include <Dini>
/* END  : Functions to test*/

DTEST_SCRIPT_START("Dini 1.6 by DracoBlue 2008");

	dt_start("Dini");
	new file[DTEST_MAXSTRING];
	dt_setstring(file,"dini-dtest.ini");
	
	fremove("dini-dtest.ini");
	
	dt_IsNot(dini_Exists(file),"dini_Exists(file)");
	dt_Is(dini_Create(file),"dini_Create(file)");
	dt_Is(dini_Exists(file),"dini_Exists(file)");

	dt_Is(dini_Set(file,"thekey","theval"),"dini_Set(file,\"thekey\",\"theval\")");
	
	dt_SSame(dini_Get(file,"thekey"),"theval","dini_Get(file,\"thekey\")");
	
	dt_Is(dini_Set(file,"otherkey","1"),"dini_Set(file,\"otherkey\",\"1\")");
	dt_SSame(dini_Get(file,"otherkey"),"1","dini_Get(file,\"otherkey\")");
	
	dt_Is(dini_Bool(file,"otherkey"),"dini_Bool(file,\"otherkey\")");

	dt_Is(dini_BoolSet(file,"thekey",false),"dini_BoolSet(file,\"thekey\",false)");
	dt_IsNot(dini_Bool(file,"thekey"),"dini_Bool(file,\"thekey\")");
	
	// Now the extraordinary cases :)
	dt_IsNot(dini_Set(file,"","something"),"dini_Set(file,\"\",\"something\")");
	dt_IsNot(dini_Set(file,"d255characters                                                                                                                                                                                                                                                 ",""),"dini_Set(file,[[string with 255 chars]],\"\")");
	dt_IsNot(dini_Set(file,"a","d255characters                                                                                                                                                                                                                                                 "),"dini_Set(file,\"a\",[[string with 255 chars]])");
	dt_Same(dini_Int(file,"a"),0,"dini_Int(file,\"a\")")
	dt_Is(dini_IntSet(file,"a",15),"dini_IntSet(file,\"a\",15)")
	dt_Same(dini_Int(file,"a"),15,"dini_Int(file,\"a\")")
	dt_Is(dini_FloatSet(file,"b",16.4),"dini_FloatSet(file,\"b\",16.4)")
	dt_Same(dini_Int(file,"b"),16,"dini_Int(file,\"b\")")
	dt_Is(dini_FloatSet(file,"b",16.0),"dini_FloatSet(file,\"b\",16.0)")
	dt_Same(floatround(dini_Float(file,"b")),16,"dini_Float(file,\"b\")")

	dt_Is(dini_Isset(file,"otherkey"),"dini_IsSet(file,\"otherkey\")");
	dt_Is(dini_Bool(file,"otherkey"),"dini_Bool(file,\"otherkey\")");
	dt_Is(dini_Unset(file,"otherkey"),"dini_Unset(file,\"otherkey\")");
	dt_IsNot(dini_Isset(file,"otherkey"),"dini_IsSet(file,\"otherkey\")");
	
	dt_Is(fexist(file),"fexists(file)");
	dt_Is(dini_Remove(file),"dini_Remove(file)");
	dt_IsNot(fexist(file),"fexists(file)");
	dt_IsNot(dini_Remove(file),"dini_Remove(file)");
	
	dt_end("Dini");
	
DTEST_SCRIPT_END