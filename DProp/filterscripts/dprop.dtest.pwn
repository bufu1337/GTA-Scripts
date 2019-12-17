#include <a_samp>
#include <dtest>
#include <dprop>
/*
  This needs dtest 1.1, get it from
    http://dracoblue.com
*/

DTEST_SCRIPT_START("DProp");

	dt_start("Get, Set & Exists");
	dt_IsNot(PropertyExists("Id1"),"PropertyExists(\"Id1\")");
	PropertySet("Id1","Hello:)");
	dt_Is(PropertyExists("Id1"),"PropertyExists(\"Id1\")");
	dt_SSame(PropertyGet("Id1"),"Hello:)","PropertyGet(\"Id1\")");
	PropertySet("Id1","Noooo");
	PropertySet("Id2","Hey");
	dt_SSame(PropertyGet("Id1"),"Noooo","PropertyGet(\"Id1\")");
	dt_SSame(PropertyGet("Id2"),"Hey","PropertyGet(\"Id2\")");
	dt_end("Get, Set & Exists");

DTEST_SCRIPT_END


