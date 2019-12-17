#include <a_samp>
#include <dtest>
#include <dutils>
/*
  This needs dtest 1.2, get it from
    http://dracoblue.com
*/

DTEST_SCRIPT_START("DUtils");

	new tmp[MAX_STRING];
	new pmt[MAX_STRING];
	new tmp_i=0;

	dt_start("StripNewLine");
	tmp[0]='H';tmp[1]='u';tmp[2]='h';tmp[3]='u';tmp[4]=13;tmp[5]=10;tmp[6]=0;
	dt_SSameNot(tmp,"Huhu","\"Huhu\"<>\"Huhu\"+13+10");
	StripNewLine(tmp);
	dt_SSame(tmp,"Huhu","StripNewLine(\"Huhu\"+13+10)");
	StripNewLine(tmp);
	dt_SSame(tmp,"Huhu","StripNewLine(\"Huhu\")");
	tmp[0]='H';tmp[1]='u';tmp[2]='h';tmp[3]='u';tmp[4]=10;tmp[5]=0;
	StripNewLine(tmp);
	dt_SSame(tmp,"Huhu","StripNewLine(\"Huhu\"+10)");
	tmp[0]=13;tmp[1]=10;tmp[2]=0;
	StripNewLine(tmp);
	dt_SSame(tmp,"","StripNewLine(13+10)");
	tmp[0]=10;tmp[1]=0;
	StripNewLine(tmp);
	dt_SSame(tmp,"","StripNewLine(10)");
	tmp[0]=0;
	StripNewLine(tmp);
	dt_SSame(tmp,"","StripNewLine()");
	dt_end("StripNewLine");

	dt_start("ret_memcpy");
	dt_SSame(ret_memcpy("Huhu",0,2),"Hu","ret_memcpy(\"Huhu\",0,2)");
	dt_SSame(ret_memcpy("Huhu",0,4),"Huhu","ret_memcpy(\"Huhu\",0,4)");
	dt_SSame(ret_memcpy("Huhu",0,10),"Huhu","ret_memcpy(\"Huhu\",0,10)");
	dt_SSame(ret_memcpy("Huhu",5,5),"","ret_memcpy(\"Huhu\",5,5)");
	dt_SSame(ret_memcpy("Huhu",1,1),"u","ret_memcpy(\"Huhu\",1,1)");
	dt_SSame(ret_memcpy("Huhu",0,1),"H","ret_memcpy(\"Huhu\",0,1)");
	dt_SSame(ret_memcpy("Huhu",1,2),"uh","ret_memcpy(\"Huhu\",1,2)");
	dt_SSame(ret_memcpy("Huhu",3,1),"u","ret_memcpy(\"Huhu\",3,1)");
	dt_SSame(ret_memcpy("Huhu",3,3),"u","ret_memcpy(\"Huhu\",3,3)");
	dt_SSame(ret_memcpy("Huhu",4,1),"","ret_memcpy(\"Huhu\",4,1)");
	dt_end("ret_memcpy");


	dt_start("copy");
	copy(tmp,"Hallo",4);  dt_SSame(tmp,"Hall","copy(dest,\"Hallo\",4)");
	copy(tmp,"Hallo",0);  dt_SSame(tmp,"","copy(dest,\"Hallo\",0)");
	copy(tmp,"Hallo",120);  dt_SSame(tmp,"Hallo","copy(dest,\"Hallo\",120)");
	copy(tmp,"Hallo",-1);  dt_SSame(tmp,"","copy(dest,\"Hallo\",-1)");
	dt_end("copy");

	dt_start("delete");
	dt_setstring(tmp,"Hello");
	dt_SSame(delete(tmp,-2),"Hello","del(dest,-2)");
	tmp=delete(tmp,1);dt_SSame(tmp,"ello","del(dest,1)");
	tmp=delete(tmp,2);dt_SSame(tmp,"lo","del(dest,2)");
	tmp=delete(tmp,0);dt_SSame(tmp,"lo","del(dest,0)");
	tmp=delete(tmp,10);dt_SSame(tmp,"","del(dest,10)");
	tmp=delete(tmp,2);dt_SSame(tmp,"","del(dest,2)");
	dt_end("delete");

	dt_start("set");
	set(tmp,"Hallo");  dt_SSame(tmp,"Hallo","set(dest,\"Hallo\")");
	set(tmp,"H");  dt_SSame(tmp,"H","set(dest,\"H\")");
	set(tmp,"");  dt_SSame(tmp,"","set(dest,\"\")");
	dt_setstring(tmp,"Hallo"); tmp[1]=0; set(tmp,tmp);  dt_SSame(tmp,"H","set(dest,\"\")");
	dt_end("set");

	dt_start("isNumeric");
	dt_IsNot(isNumeric("Hallo"),"isNumeric(\"Hallo\")");
	dt_IsNot(isNumeric("1Hallo2"),"isNumeric(\"1Hallo2\")");
	dt_IsNot(isNumeric("-1Hallo2"),"isNumeric(\"-1Hallo2\")");
	dt_Is(isNumeric("+10"),"isNumeric(\"+10\")");
	dt_IsNot(isNumeric("1-0"),"isNumeric(\"1-0\")");
	dt_IsNot(isNumeric("2-"),"isNumeric(\"2-\")");
	dt_Is(isNumeric("-10"),"isNumeric(\"-10\")");
	dt_Is(isNumeric("-10"),"isNumeric(\"-10\")");
	dt_IsNot(isNumeric("-"),"isNumeric(\"-\")");
	dt_IsNot(isNumeric("+"),"isNumeric(\"+\")");
	dt_IsNot(isNumeric(""),"isNumeric(\"\")");
	dt_end("isNumeric");

	dt_start("equal");
	dt_Is(equal("Hallo","hallo",true),"equal(\"Hallo\",\"hallo\",true)");
	dt_Is(equal("Hallo","Hallo",true),"equal(\"Hallo\",\"Hallo\",true)");
	dt_IsNot(equal("Hall","hallo",true),"equal(\"Hall\",\"hallo\",true)");
	dt_IsNot(equal("Hallo","hallo",false),"equal(\"Hall\",\"hallo\",false)");
	dt_IsNot(equal("","hallo",false),"equal(\"\",\"hallo\",false)");
	dt_Is(equal("","",true),"equal(\"\",\"\",true)");
	dt_Is(equal("","",false),"equal(\"\",\"\",false)");
	dt_end("equal");

	dt_start("strreplace");
	dt_SSame(strreplace("a","A","Hallo"),"HAllo","strreplace(\"a\",\"A\",\"Hallo\")");
	dt_SSame(strreplace("ll","LL","Hallo"),"HaLLo","strreplace(\"ll\",\"LL\",\"Hallo\")");
	dt_SSame(strreplace("","AA","Hallo"),"Hallo","strreplace(\"\",\"AA\",\"Hallo\")");
	dt_SSame(strreplace("","",""),"","strreplace(\"\",\"\",\"\")");
	dt_SSame(strreplace("","","Hallo"),"Hallo","strreplace(\"\",\"\",\"\")");
	dt_SSame(strreplace("H","","HallHo"),"allo","strreplace(\"H\",\"\",\"HallHo\")");
	dt_SSame(strreplace("H","","Hallo"),"allo","strreplace(\"H\",\"\",\"Hallo\")");
	dt_SSame(strreplace("D","","Hallo"),"Hallo","strreplace(\"D\",\"\",\"Hallo\")");
	dt_SSame(strreplace("o","-","Hallo"),"Hall-","strreplace(\"o\",\"-\",\"Hallo\")");
	dt_SSame(strreplace("o","","Hallo"),"Hall","strreplace(\"o\",\"\",\"Hallo\")");
	dt_SSame(strreplace("|","&D;","Ha|llo"),"Ha&D;llo","strreplace(\"|\",\"&D;\",\"Ha|llo\")");
	dt_SSame(strreplace("A","AA","AAA"),"AAAAAA","strreplace(\"A\",\"AA\",\"AAA\")");
	dt_end("strreplace");

	dt_start("strtok");
	dt_setstring(tmp,"was ist den  das?");
	dt_setstring(pmt,"");
	tmp_i=0;
	pmt=strtok(tmp,tmp_i);	dt_SSame(pmt,"was","strtok(\"was ist den  das?\")");
	pmt=strtok(tmp,tmp_i);	dt_SSame(pmt,"ist","strtok(\"ist den  das?\")");
	pmt=strtok(tmp,tmp_i);	dt_SSame(pmt,"den","strtok(\"den  das?\")");
	pmt=strtok(tmp,tmp_i);	dt_SSame(pmt,"","strtok(\" das?\")");
	pmt=strtok(tmp,tmp_i);	dt_SSame(pmt,"das?","strtok(\"das?\")");
	pmt=strtok(tmp,tmp_i);	dt_SSame(pmt,"","strtok(\"\")");
	dt_end("strtok");

	dt_start("delete");
	dt_setstring(tmp,"was ist den  das?");
	tmp=delete(tmp,1);	dt_SSame(tmp,"as ist den  das?","delete(\"was ist den  das?\")");
	tmp=delete(tmp,0);	dt_SSame(tmp,"as ist den  das?","delete(\"as ist den  das?\")");
	tmp=delete(tmp,2);	dt_SSame(tmp," ist den  das?","delete(\" ist den  das?\")");
	tmp=delete(tmp,-1);	dt_SSame(tmp," ist den  das?","delete(\" ist den  das?\")");
	tmp=delete(tmp,5);	dt_SSame(tmp,"den  das?","delete(\" ist den  das?\")");
	tmp=delete(tmp,1231);	dt_SSame(tmp,"","delete(\"den  das?\")");
	dt_end("delete");

	dt_start("mod + div");
	dt_Same(mod(5,2),1,"mod(5,2)");
	dt_Same(mod(5,1),0,"mod(5,1)");
	dt_Same(mod(0,2),0,"mod(0,2)");
	dt_Same(div(5,2),2,"div(5,2)");
	dt_Same(div(5,1),5,"div(5,1)");
	dt_Same(div(0,2),0,"div(0,2)");
	dt_end("mod + div");

	dt_start("StrToInt + IntToStr");
	dt_Same(StrToInt("50"),50,"StrToInt(50)");
	dt_Same(StrToInt("-2"),-2,"StrToInt(-2)");
	dt_Same(StrToInt(IntToStr(-2)),-2,"StrToInt(IntToStr(-2))");
	dt_end("StrToInt");

	dt_start("hash + num_hash");
	dt_SSame(hash("Huhu"),hash("Huhu"),"hash(\"Huhu\")==hash(\"Huhu\")");
	dt_SSameNot(hash("huhu"),hash("Huhu"),"hash(\"huhu\")!=hash(\"Huhu\")");
	dt_SSameNot(hash("Huh"),hash("Huhu"),"hash(\"Huh\")!=hash(\"Huhu\")");
	dt_Same(num_hash("Huhu"),num_hash("Huhu"),"num_hash(\"Huhu\")==num_hash(\"Huhu\")");
	dt_SameNot(num_hash("huhu"),num_hash("Huhu"),"num_hash(\"huhu\")!=num_hash(\"Huhu\")");
	dt_SameNot(num_hash("Huh"),num_hash("Huhu"),"num_hash(\"Huh\")!=num_hash(\"Huhu\")");
	dt_end("hash + num_hash");


	dt_start("strlower + strupper");
	dt_SSame(strlower("Huhu"),"huhu","strlower(\"Huhu\")");
	dt_SSame(strlower(""),"","strlower(\"\")");
	dt_SSame(strupper(strlower("Huhu")),"HUHU","strupper(strlower(\"Huhu\"))");
	dt_SSame(strupper("Huhu"),"HUHU","strupper(\"Huhu\")");
	dt_SSame(strupper(""),"","strupper(\"\")");
	dt_SSame(strlower(strupper("Huhu")),"huhu","strlower(strupper(\"Huhu\"))");
	dt_end("strlower + strupper");

	dt_start("ValidEmail");
	dt_Is(ValidEmail("JanS@DracoBlue.de"),"ValidEmail(\"JanS@DracoBlue.de\")");
	dt_IsNot(ValidEmail("JanS@DracoBlue."),"ValidEmail(\"JanS@DracoBlue.\")");
	dt_IsNot(ValidEmail("JanS@DracoBlue.d"),"ValidEmail(\"JanS@DracoBlue.d\")");
	dt_IsNot(ValidEmail("JanS@DracoBlue.deasd"),"ValidEmail(\"JanS@DracoBlue.deasd\")");
	dt_IsNot(ValidEmail("JanS@DracoB@lue.de"),"ValidEmail(\"JanS@DracoB@lue.de\")");
	dt_IsNot(ValidEmail("JanS@Drac/\\oBlue.de"),"ValidEmail(\"JanS@Drac/\\oBlue.de\")");
	dt_Is(ValidEmail("JanS@Drac-oBlue.de"),"ValidEmail(\"JanS@Drac-oBlue.de\")");
	dt_Is(ValidEmail("J-.anS@DracoBlue.de"),"ValidEmail(\"J-.anS@DracoBlue.de\")");
	dt_IsNot(ValidEmail("JanS@DracoBluede"),"ValidEmail(\"JanS@DracoBluede\")");
	dt_IsNot(ValidEmail("JanSDracoBlue.de"),"ValidEmail(\"JanSDracoBlue.de\")");
	dt_end("ValidEmail");

	dt_start("mktime + Now + Time");
	dt_Same(mktime(1,1,1,1,1,2000),948762061,"mktime(1,1,1,1,1,2000)");
	dt_SameNot(Time(),0,"Time()");
	dt_SameNot(Now(),0,"Now()");
	dt_end("mktime");
	
	dt_start("trunc");
	dt_Same(trunc(5.4),5,"trunc(5.4)");
	dt_Same(trunc(5.99),5,"trunc(5.99)");
	dt_Same(trunc(5.99999),5,"trunc(5.99999)");
	dt_Same(trunc(5.999999),5,"trunc(5.999999)");
	dt_Same(trunc(-0.1),-1,"trunc(-0.1)");
	dt_end("trunc");

	dt_start("HexToInt + IntToHex");
	dt_Same(HexToInt("FF"),255,"HexToInt(\"FF\")");
	dt_Same(HexToInt(""),0,"HexToInt(\"\")");
	dt_Same(HexToInt("0"),0,"HexToInt(\"0\")");
	dt_Same(HexToInt("F"),15,"HexToInt(\"F\")");
	dt_SSame(IntToHex(255),"FF","IntToHex(255)");
	dt_SSame(IntToHex(0),"","IntToHex(0)");
	dt_SSame(IntToHex(1),"1","IntToHex(1)");
	dt_SSame(IntToHex(14),"E","IntToHex(14)");
	dt_SSame(IntToHex(15),"F","IntToHex(15)");
	dt_SSame(IntToHex(16),"10","IntToHex(16)");
	dt_SSame(IntToHex(17),"11","IntToHex(17)");
	dt_SSame(IntToHex(18),"12","IntToHex(18)");
	dt_Same(HexToInt(IntToHex(0)),0,"HexToInt(IntToHex(0))");
	dt_Same(HexToInt(IntToHex(1)),1,"HexToInt(IntToHex(1))");
	dt_Same(HexToInt(IntToHex(15)),15,"HexToInt(IntToHex(15))");
	dt_Same(HexToInt(IntToHex(16)),16,"HexToInt(IntToHex(16))");
	dt_Same(HexToInt(IntToHex(17)),17,"HexToInt(IntToHex(17))");
	dt_end("HexToInt + IntToHex");
	

DTEST_SCRIPT_END


