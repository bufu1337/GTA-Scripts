#include <a_samp>
#include <dtest>

/* START: Functions to test : */
#define MAX_STRING 255
public left(const source[], length)
{
	length = min(length, strlen(source));
	new retdat[MAX_STRING];
	strmid(retdat, source, 0, length);
	return retdat;
}
public right(const source[], length)
{
	new size = strlen(source);
	length = min(length, size);
	new retdat[MAX_STRING];
	strmid(retdat, source, size - length, size);
	return retdat;
}
/* END  : Functions to test*/

  DTEST_SCRIPT_START("left() and right() by Y_Less");

	dt_start("left");
	new tmp[DTEST_MAXSTRING];
	dt_setstring(tmp,"Hello World");

	// Check if left works for vars and with static values
	dt_SSame(left("Hello World",4),"Hell","left(\"Hello World\",4)");
	dt_SSame(left(tmp,4),"Hell","left(\"Hello World\",4)");

	// Is tmp sill the value?
	dt_SSame(tmp,"Hello World","tmp");
	
	// What about empty values?
	dt_SSame(left("",5),"","left(\"\",5)");

	// What about 0 count?
	dt_SSame(left("Hello",0),"","left(\"Hello\",0)");
	dt_SSameNot(left("Hello",0),"Hello","left(\"Hello\",0)");

	// What about negative count?
	dt_SSame(left("Hello",-5),"","left(\"Hello\",-5)");
	dt_SSameNot(left("Hello",-5),"Hello","left(\"Hello\",-5)");

	// What about to much signs? More then MAX_STRING
	dt_SSame(left("Hello",MAX_STRING+2),"Hello","left(\"Hello\",MAX_STRING+2)");
	dt_end("left");


	dt_start("right");
	// Check if right works for vars and with static values
	dt_SSame(right("Hello World",4),"orld","right(\"Hello World\",4)");
	dt_SSame(right(tmp,4),"orld","right(\"Hello World\",4)");

	// Is tmp sill the value?
	dt_SSame(tmp,"Hello World","tmp");

	// What about empty values?
	dt_SSame(right("",5),"","right(\"\",5)");

	// What about 0 count?
	dt_SSame(right("Hello",0),"","right(\"Hello\",0)");
	dt_SSameNot(right("Hello",0),"Hello","right(\"Hello\",0)");

	// What about negative count?
	dt_SSame(right("Hello",-5),"","right(\"Hello\",-5)");

	// What about to much signs? More then MAX_STRING
	dt_SSame(right("Hello",MAX_STRING+2),"Hello","right(\"Hello\",MAX_STRING+2)");
	dt_end("left");
    dt_mainend();

DTEST_SCRIPT_END