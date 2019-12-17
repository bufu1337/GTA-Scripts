#include <a_samp>

new SystemTime[12];
forward RealTimeUpdate();
forward TimeUpdate();

public OnFilterScriptInit()
{
	SetTimer("RealTimeUpdate",1,0);
	SetTimer("TimeUpdate",10000, 1);
	print("\n--------------------------------------");
	print(" Reallifetime Uhr");
	print("--------------------------------------\n");
	return 1;
}
public OnFilterScriptExit()
{
	return 1;
}
public RealTimeUpdate()
{
    new h=0, m=0, s=0;
    //new string[256];
    SetWorldTime(h);
    //new Text:Clock;
    gettime(h,m,s);
    /*if (m <= 9){format(string,25,"%d:%d",h,m);
    } else {format(string,25,"%d:%d",h,m);}
    TextDrawHideForAll(Clock);
    Clock=TextDrawCreate(552,28,string);
    TextDrawLetterSize(Clock,0.5,1.8);
    TextDrawFont(Clock,3);
    TextDrawBackgroundColor(Clock,0x000000AA);
    TextDrawSetOutline(Clock,2);
    TextDrawShowForAll(Clock);*/
    if (h == 0){SetWorldTime(0);}
    if (h == 1){SetWorldTime(1);}
    if (h == 2){SetWorldTime(2);}
    if (h == 3){SetWorldTime(3);}
    if (h == 4){SetWorldTime(4);}
    if (h == 5){SetWorldTime(5);}
    if (h == 6){SetWorldTime(6);}
    if (h == 7){SetWorldTime(7);}
    if (h == 8){SetWorldTime(8);}
    if (h == 9){SetWorldTime(9);}
    if (h == 10){SetWorldTime(10);}
    if (h == 11){SetWorldTime(11);}
    if (h == 12){SetWorldTime(12);}
    if (h == 13){SetWorldTime(13);}
    if (h == 14){SetWorldTime(14);}
    if (h == 15){SetWorldTime(15);}
    if (h == 16){SetWorldTime(16);}
    if (h == 17){SetWorldTime(17);}
    if (h == 18){SetWorldTime(18);}
    if (h == 19){SetWorldTime(19);}
    if (h == 20){SetWorldTime(20);}
    if (h == 21){SetWorldTime(21);}
    if (h == 22){SetWorldTime(22);}
    if (h == 23){SetWorldTime(23);}
    if (h == 24){SetWorldTime(24);}
    SetTimer("RealTimeUpdate",3000,0);
    //format(string, sizeof(string), "The time is updated - %d:%d:%d", h, m, s);
    //print(string);
    return 1;
    }

    public TimeUpdate() {
    new Hour, Minute, Seconds;
    new strings[256];
    new string[256];
    new Text:Clock;
    gettime(Hour, Minute, Seconds);
    if(Hour < 10) {
    format(SystemTime, sizeof(SystemTime), "0%d",Hour);
    } else {
    format(SystemTime, sizeof(SystemTime), "%d",Hour);
    }
    if(Minute < 10) {
    format(SystemTime, sizeof(SystemTime), "%s:0%d",SystemTime,Minute);
    } else {
    format(SystemTime, sizeof(SystemTime), "%s:%d",SystemTime,Minute);
    }
    if (Minute <= 9) {
    format(string,25,"%d:%0d",Hour,Minute);
    } else {
    format(string,25,"%d:%d",Hour,Minute);}
    TextDrawHideForAll(Clock);
    Clock=TextDrawCreate(552,28,SystemTime);
    TextDrawLetterSize(Clock,0.5,1.8);
    TextDrawFont(Clock,3);
    TextDrawBackgroundColor(Clock,0x000000AA);
    TextDrawSetOutline(Clock,2);
    TextDrawShowForAll(Clock);
    format(strings, sizeof(strings), "System time: %s", SystemTime);
    printf(strings);
    return 1;
    }
