/*
 *            DTest functions 1.1
 *       (c) Copyright 2006 by DracoBlue
 *
 * @version   : 1.1
 * @author    : DracoBlue (http://dracoblue.com)
 * @date      : 24th April 2006
 * @update    : 12th May   2006
 *
 * This file is provided as is (no warranties).
 *
 */

#if defined _dtest_included
  #endinput
#endif
#define _dtest_included
#pragma library DTest

#define DTEST_MAXSTRING 255
#define DTEST_SCRIPT_START public OnFilterScriptInit() { dt_mainstart
#define DTEST_SCRIPT_END   dt_mainend();  return 1; } public OnFilterScriptExit() { return 1; }

/* Mainpart-Sections */
public dt_mainstart(title[]) {
	printf("");
	printf(" _____________________________________________________________________________");
	printf(" :                                                                   \\ DTEST |");
	printf(" '                                                                    `------´");
  	printf("    Testing: %s",title);

        new hour,minute,second,year,month,day;
        gettime(hour, minute, second);
        getdate(year, month, day);
        new month2[DTEST_MAXSTRING];
        month2[0]=0;
        if (month==1) dt_setstring(month2,"Jan");
        if (month==2) dt_setstring(month2,"Feb");
        if (month==3) dt_setstring(month2,"Mar");
        if (month==4) dt_setstring(month2,"Apr");
        if (month==5) dt_setstring(month2,"May");
        if (month==6) dt_setstring(month2,"Jun");
        if (month==7) dt_setstring(month2,"Jul");
        if (month==8) dt_setstring(month2,"Aug");
        if (month==9) dt_setstring(month2,"Sep");
        if (month==10) dt_setstring(month2,"Oct");
        if (month==11) dt_setstring(month2,"Nov");
        if (month==12) dt_setstring(month2,"Dec");
  	printf("     (%d:%d:%d, %d. %s %d)",hour,minute,second,day,month2,year);
	printf("");
}

public dt_mainend() {
	printf("                                                                         ");
	printf("  __                                                                         .");
	printf(" |__\\________________________________________________________________________:");
	printf("");
}

/* Sub-Sections */
public dt_start(title[]) {
	printf("      <%s>",title);
}
public dt_end(title[]) {
	printf("      ");
}

/* Print results */
public dt_ok(what[]) {
	printf("       [OK] %s",what);
}

public dt_no(what[]) {
	printf("       [--] %s",what);
}


/* This function is used for workin string handling */
public dt_setstring(dest[],source[]) {
  new count = strlen(source);
  new i=0;
  for (i=0;i<count;i++) {
	dest[i]=source[i];
  }
  dest[count]=0;
}


/* Boolean stuff */
public dt_Is(what,descr[]) {
  new tmp[DTEST_MAXSTRING];
  dt_setstring(tmp,descr);
  if (what) {
    strcat(tmp," true == true",DTEST_MAXSTRING);
    dt_ok(tmp);
  } else {
    strcat(tmp," true <> false",DTEST_MAXSTRING);
    dt_no(tmp);
  }
}

public dt_IsNot(what,descr[]) {
  new tmp[DTEST_MAXSTRING];
  dt_setstring(tmp,descr);
  if (!what) {
    strcat(tmp," false == false",DTEST_MAXSTRING);
    dt_ok(tmp);
  } else {
    strcat(tmp," false <> true",DTEST_MAXSTRING);
    dt_no(tmp);
  }
}

/* String stuff */
public dt_SSame(what[],what2[],descr[]) {
  new tmp[DTEST_MAXSTRING];
  dt_setstring(tmp,descr);
  strcat(tmp," ",DTEST_MAXSTRING);
  strcat(tmp,what,DTEST_MAXSTRING);
  if ((strcmp(what,what2,false)==0)&&(strlen(what)==strlen(what2))) {
    strcat(tmp," == ",DTEST_MAXSTRING);
  } else {
    strcat(tmp," <> ",DTEST_MAXSTRING);
  }
  strcat(tmp,what2,DTEST_MAXSTRING);

  if ((strcmp(what,what2,false)==0)&&(strlen(what)==strlen(what2))) {
    dt_ok(tmp);
  } else {
    dt_no(tmp);
  }
}

public dt_SSameNot(what[],what2[],descr[]) {
  new tmp[DTEST_MAXSTRING];
  dt_setstring(tmp,descr);
  strcat(tmp," ",DTEST_MAXSTRING);
  strcat(tmp,what,DTEST_MAXSTRING);
  if ((strcmp(what,what2,false)==0)&&(strlen(what)==strlen(what2))) {
    strcat(tmp," == ",DTEST_MAXSTRING);
  } else {
    strcat(tmp," <> ",DTEST_MAXSTRING);
  }
  strcat(tmp,what2,DTEST_MAXSTRING);

  if ((strcmp(what,what2,false)==0)&&(strlen(what)==strlen(what2))) {
    dt_no(tmp);
  } else {
    dt_ok(tmp);
  }
}

/* Value stuff */
public dt_Same(what,what2,descr[]) {
  new tmp[DTEST_MAXSTRING];
  new tmp2[DTEST_MAXSTRING];
  dt_setstring(tmp,descr);
  strcat(tmp," ",DTEST_MAXSTRING);
  valstr(tmp2,what);
  strcat(tmp,tmp2,DTEST_MAXSTRING);
  if (what==what2) {
    strcat(tmp," == ",DTEST_MAXSTRING);
  } else {
    strcat(tmp," <> ",DTEST_MAXSTRING);
  }
  valstr(tmp2,what2);
  strcat(tmp,tmp2,DTEST_MAXSTRING);

  if (what==what2) {
    dt_ok(tmp);
  } else {
    dt_no(tmp);
  }
}

public dt_SameNot(what,what2,descr[]) {
  new tmp[DTEST_MAXSTRING];
  new tmp2[DTEST_MAXSTRING];

  dt_setstring(tmp,descr);
  strcat(tmp," ",DTEST_MAXSTRING);
  valstr(tmp2,what);
  strcat(tmp,tmp2,DTEST_MAXSTRING);
  if (what!=what2) {
    strcat(tmp," == ",DTEST_MAXSTRING);
  } else {
    strcat(tmp," <> ",DTEST_MAXSTRING);
  }
  valstr(tmp2,what2);
  strcat(tmp,tmp2,DTEST_MAXSTRING);

  if (what==what2) {
    dt_no(tmp);
  } else {
    dt_ok(tmp);
  }
}

