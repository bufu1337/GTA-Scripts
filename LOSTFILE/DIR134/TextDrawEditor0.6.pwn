#include <a_samp>

#define dcmd(%1,%2,%3) if((strcmp((%3)[1], #%1, true, (%2)) == 0)&&((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == ' ') && (dcmd_%1(playerid, (%3)[(%2) + 2])))))return 1

#define red 0
#define blue 1
#define green 2
#define yellow 3
#define pink 4
#define light_blue 5
#define white 6
#define black 7

new Menu:Main, Menu:Main2, Menu:AlignmentM, Menu:ColorM, Menu:TransparencyM, Menu:Box1M, Menu:ShadowM, Menu:ProportionalM, Menu:FontM, Menu:OutlineM, Text:Textdraw[95],
	Menu:PreMain, Menu:PreMain2, Menu:PreMain3, Menu:PreMain4, Menu:PreMain5, Menu:PreMain6, Menu:PreMain7, Menu:PreMain8, Menu:PreMain9, Menu:PreMain10;
new textdrawtext[95][256], Float:textx[95] = {1.0,...}, Float:texty[95] = {1.0,...}, Float:lettersizex[95] = {1.0,...}, Float:lettersizey[95] = {1.0,...}, Float:boxsizex[95] = {0.0,...},
    Float:boxsizey[95] = {0.0,...}, alignment[95], box[95], boxcolor[95] = {0x000000FF,...}, backcolor[95] = {0x000000FF,...}, proportional[95] = {1,...}, font[95] = {3,...}, shadow[95] = {1,...}, outline[95] = {1,...},
    textcolor[95] = {0xFFFFFFFF,...};
	
new menu, writing, saving, movingtext, lettersizing, color, boxsizing, currtextdraw, textdrawactive[95];

new red100,red80,red60,red40,red20,red0;
new blue100,blue80,blue60,blue40,blue20,blue0;
new green100,green80,green60,green40,green20,green0;
new yellow100,yellow80,yellow60,yellow40,yellow20,yellow0;
new pink100,pink80,pink60,pink40,pink20,pink0;
new light_blue100,light_blue80,light_blue60,light_blue40,light_blue20,light_blue0;
new white100,white80,white60,white40,white20,white0;
new black100,black80,black60,black40,black20,black0;

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" TextDraw Filtescript by Zamaroht Loaded!");
	print("--------------------------------------\n");
	
	color=0xFFFFFFFF;
	
	red100=0xff0000ff;
	blue100=0x0000ffff;
	green100=0x00ff00ff;
	yellow100=0xffff00ff;
	pink100=0xff00ffff;
	light_blue100=0x00ffffff;
	white100=0xffffffff;
	black100=0x000000ff;
	
	red80=0xff0000cc;
	blue80=0x0000ffcc;
	green80=0x00ff00cc;
	yellow80=0xffff00cc;
	pink80=0xff00ffcc;
	light_blue80=0x00ffffcc;
	white80=0xffffffcc;
	black80=0x000000cc;
	
	red60=0xff000099;
	blue60=0x0000ff99;
	green60=0x00ff0099;
	yellow60=0xffff0099;
	pink60=0xff00ff99;
	light_blue60=0x00ffff99;
	white60=0xffffff99;
	black60=0x00000099;
	
	red40=0xff000066;
	blue40=0x0000ff66;
	green40=0x00ff0066;
	yellow40=0xffff0066;
	pink40=0xff00ff66;
	light_blue40=0x00ffff66;
	white40=0xffffff66;
	black40=0x00000066;
	
	red20=0xff000033;
	blue20=0x0000ff33;
	green20=0x00ff0033;
	yellow20=0xffff0033;
	pink20=0xff00ff33;
	light_blue20=0x00ffff33;
	white20=0xffffff33;
	black20=0x00000033;
	
	red0=0xff000000;
	blue0=0x0000ff00;
	green0=0x00ff0000;
	yellow0=0xffff0000;
	pink0=0xff00ff00;
	light_blue0=0x00ffff00;
	white0=0xffffff00;
	black0=0x00000000;
	
	FontM = CreateMenu("Font",2,200,100,150,100);
	AddMenuItem(FontM, 0, "Type 0");          //0
	AddMenuItem(FontM, 0, "Type 1");          //1
	AddMenuItem(FontM, 0, "Type 2");          //2
	AddMenuItem(FontM, 0, "Type 3");          //3
	OutlineM = CreateMenu("Outline",2,200,100,150,100);
	AddMenuItem(OutlineM, 0, "On");           //0
	AddMenuItem(OutlineM, 0, "Off");          //1
	Box1M = CreateMenu("Box",2,200,100,150,100);
	AddMenuItem(Box1M, 0, "On");           //0
	AddMenuItem(Box1M, 0, "Off");          //1
	ShadowM = CreateMenu("Shadow",2,200,100,150,100);
	AddMenuItem(ShadowM, 0, "Off");           //0
	AddMenuItem(ShadowM, 0, "Size 1");        //1
	AddMenuItem(ShadowM, 0, "Size 2");        //2
	AddMenuItem(ShadowM, 0, "Size 3");        //3
	AddMenuItem(ShadowM, 0, "Size 4");        //4
	AddMenuItem(ShadowM, 0, "Size 5");        //5
	AddMenuItem(ShadowM, 0, "Size 6");        //6
	AddMenuItem(ShadowM, 0, "Size 7");        //7
	AddMenuItem(ShadowM, 0, "Size 8");        //8
	AddMenuItem(ShadowM, 0, "Size 9");        //9
	AddMenuItem(ShadowM, 0, "Size 10");       //10
	AlignmentM = CreateMenu("Alignment",2,200,100,150,100);
	AddMenuItem(AlignmentM, 0, "Justified");           //0
	AddMenuItem(AlignmentM, 0, "Left");                //1
	AddMenuItem(AlignmentM, 0, "Centre");              //2
	AddMenuItem(AlignmentM, 0, "Right");               //3
	ProportionalM = CreateMenu("Proportional",2,200,100,150,100);
	AddMenuItem(ProportionalM, 0, "On");           //0
	AddMenuItem(ProportionalM, 0, "Off");          //1
	ColorM = CreateMenu("Text Color",2,200,100,150,100);
	AddMenuItem(ColorM, 0, "Red");                 //0
	AddMenuItem(ColorM, 0, "Blue");                //1
	AddMenuItem(ColorM, 0, "Green");               //2
	AddMenuItem(ColorM, 0, "Yellow");              //3
	AddMenuItem(ColorM, 0, "Pink");                //4
	AddMenuItem(ColorM, 0, "Light Blue");          //5
	AddMenuItem(ColorM, 0, "White");               //6
	AddMenuItem(ColorM, 0, "Black");               //7
	TransparencyM = CreateMenu("Transparency",2,200,100,150,100);
	AddMenuItem(TransparencyM, 0, "100%");                //0
	AddMenuItem(TransparencyM, 0, "80%");                 //1
	AddMenuItem(TransparencyM, 0, "60%");                 //2
	AddMenuItem(TransparencyM, 0, "40%");                 //3
	AddMenuItem(TransparencyM, 0, "20%");                 //4
	AddMenuItem(TransparencyM, 0, "0%");                  //5
	Main = CreateMenu("TextDraw",2,200,100,150,100);
	AddMenuItem(Main, 0, "Write Text");                //0
	AddMenuItem(Main, 0, "Select Position");           //1
	AddMenuItem(Main, 0, "Letter Size");               //2
	AddMenuItem(Main, 0, "Alignment");                 //3
	AddMenuItem(Main, 0, "Text Color");                //4
	AddMenuItem(Main, 0, "Box (+box color/+box size)");//5
	AddMenuItem(Main, 0, "Background Color");          //6
	AddMenuItem(Main, 0, "Shadow");                    //7
	AddMenuItem(Main, 0, "Set Proportional");          //8
	AddMenuItem(Main, 0, "Font");                      //9
	AddMenuItem(Main, 0, "Outline");                   //10
	AddMenuItem(Main, 0, "More...");                   //11
	Main2 = CreateMenu("TextDraw",2,200,100,300,10);
	AddMenuItem(Main2, 0, "Go back...");                //0
	AddMenuItem(Main2, 0, "-> Save all textdraws to file!");       //1
	AddMenuItem(Main2, 0, "Delete Textdraw");           //2
	for(new i;i<95;i++)
		{
		Textdraw[i] = TextDrawCreate(0.0,0.0," ");
		textdrawtext[i] = " ";
		UpdateTextDraw(i,0);
		}
	return 1;
}

public OnFilterScriptExit()
{
	for(new i;i<95;i++)
		{
		if(textdrawactive[i]) TextDrawDestroy(Textdraw[i]);
		}
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SendClientMessage(playerid,0x554466AA,"Do /text for create new TextDraw, /edit [id] for jump directly to a individual");
	SendClientMessage(playerid,0x554466AA,"textdraw edition.");
	for(new i;i<95;i++)
		{
		TextDrawShowForPlayer(playerid, Textdraw[i]);
		}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/text", cmdtext, true, 10) == 0)
	{
		if(writing || movingtext || lettersizing || boxsizing || saving)
			{
			SendClientMessage(playerid,0x554466AA,"Complete the current operation first");
			}
		else
			{
			menu=100;
			PreMain = CreateMenu("Select Textdraw",2,200,100,150,100);
			PreMain2 = CreateMenu("Select Textdraw",2,200,100,150,100);
			PreMain3 = CreateMenu("Select Textdraw",2,200,100,150,100);
			PreMain4 = CreateMenu("Select Textdraw",2,200,100,150,100);
			PreMain5 = CreateMenu("Select Textdraw",2,200,100,150,100);
			PreMain6 = CreateMenu("Select Textdraw",2,200,100,150,100);
			PreMain7 = CreateMenu("Select Textdraw",2,200,100,150,100);
			PreMain8 = CreateMenu("Select Textdraw",2,200,100,150,100);
			PreMain9 = CreateMenu("Select Textdraw",2,200,100,150,100);
			PreMain10 = CreateMenu("Select Textdraw",2,200,100,150,100);
			new tmpvar;
			for(new i;i<95;i++)
				{
				if(textdrawactive[i]==1) tmpvar=i;
				}
			new tmpstr[20];
			AddMenuItem(PreMain, 0, "New Textdraw...");
			for(new i;i<95;i++)
				{
				if(i<=tmpvar && i < 10)
					{
					if(textdrawactive[i]) format(tmpstr,20,"Textdraw %d",i);
					else format(tmpstr,20,"...",i);
					AddMenuItem(PreMain, 0, tmpstr);
					}
				}
			if(tmpvar >= 10)
				{
				AddMenuItem(PreMain, 0, "Next page...");
				AddMenuItem(PreMain2, 0, "Previous page...");
				for(new i;i<95;i++)
					{
					if(i<=tmpvar && i >= 10 && i < 20)
						{
						if(textdrawactive[i]) format(tmpstr,20,"Textdraw %d",i);
						else format(tmpstr,20,"...",i);
						AddMenuItem(PreMain2, 0, tmpstr);
						}
					}
				if(tmpvar >= 20)
					{
					AddMenuItem(PreMain2, 0, "Next page...");
					AddMenuItem(PreMain3, 0, "Previous page...");
					for(new i;i<95;i++)
						{
						if(i<=tmpvar && i >= 20 && i < 30)
							{
							if(textdrawactive[i]) format(tmpstr,20,"Textdraw %d",i);
							else format(tmpstr,20,"...",i);
							AddMenuItem(PreMain3, 0, tmpstr);
							}
						}
					if(tmpvar >= 30)
						{
						AddMenuItem(PreMain3, 0, "Next page...");
						AddMenuItem(PreMain4, 0, "Previous page...");
						for(new i;i<95;i++)
							{
							if(i<=tmpvar && i >= 30 && i < 40)
								{
								if(textdrawactive[i]) format(tmpstr,20,"Textdraw %d",i);
								else format(tmpstr,20,"...",i);
								AddMenuItem(PreMain4, 0, tmpstr);
								}
							}
						if(tmpvar >= 40)
							{
							AddMenuItem(PreMain4, 0, "Next page...");
							AddMenuItem(PreMain5, 0, "Previous page...");
							for(new i;i<95;i++)
								{
								if(i<=tmpvar && i >= 40 && i < 50)
									{
									if(textdrawactive[i]) format(tmpstr,20,"Textdraw %d",i);
									else format(tmpstr,20,"...",i);
									AddMenuItem(PreMain5, 0, tmpstr);
									}
								}
							if(tmpvar >= 50)
								{
								AddMenuItem(PreMain5, 0, "Next page...");
								AddMenuItem(PreMain6, 0, "Previous page...");
								for(new i;i<95;i++)
									{
									if(i<=tmpvar && i >= 50 && i < 60)
										{
										if(textdrawactive[i]) format(tmpstr,20,"Textdraw %d",i);
										else format(tmpstr,20,"...",i);
										AddMenuItem(PreMain6, 0, tmpstr);
										}
									}
								if(tmpvar >= 60)
									{
									AddMenuItem(PreMain6, 0, "Next page...");
									AddMenuItem(PreMain7, 0, "Previous page...");
									for(new i;i<95;i++)
										{
										if(i<=tmpvar && i >= 60 && i < 70)
											{
											if(textdrawactive[i]) format(tmpstr,20,"Textdraw %d",i);
											else format(tmpstr,20,"...",i);
											AddMenuItem(PreMain7, 0, tmpstr);
											}
										}
									if(tmpvar >= 70)
										{
										AddMenuItem(PreMain7, 0, "Next page...");
										AddMenuItem(PreMain8, 0, "Previous page...");
										for(new i;i<95;i++)
											{
											if(i<=tmpvar && i >= 70 && i < 80)
												{
												if(textdrawactive[i]) format(tmpstr,20,"Textdraw %d",i);
												else format(tmpstr,20,"...",i);
												AddMenuItem(PreMain8, 0, tmpstr);
												}
											}
										if(tmpvar >= 80)
											{
											AddMenuItem(PreMain8, 0, "Next page...");
											AddMenuItem(PreMain9, 0, "Previous page...");
											for(new i;i<95;i++)
												{
												if(i<=tmpvar && i >= 80 && i < 90)
													{
													if(textdrawactive[i]) format(tmpstr,20,"Textdraw %d",i);
													else format(tmpstr,20,"...",i);
													AddMenuItem(PreMain9, 0, tmpstr);
													}
												}
											if(tmpvar >= 90)
												{
												AddMenuItem(PreMain9, 0, "Next page...");
												AddMenuItem(PreMain10, 0, "Previous page...");
												for(new i;i<95;i++)
													{
													if(i<=tmpvar && i >= 90 && i < 100)
														{
														if(textdrawactive[i]) format(tmpstr,20,"Textdraw %d",i);
														else format(tmpstr,20,"...",i);
														AddMenuItem(PreMain10, 0, tmpstr);
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			ShowMenuForPlayer(PreMain, playerid);
			TogglePlayerControllable(playerid,0);
			}
		return 1;
	}
	dcmd(edit,4,cmdtext);
	dcmd(moveleft,8,cmdtext);
	dcmd(moveright,9,cmdtext);
	dcmd(moveup,6,cmdtext);
	dcmd(movedown,8,cmdtext);
	dcmd(offsetx,7,cmdtext);
	dcmd(offsety,7,cmdtext);
	dcmd(width,5,cmdtext);
	dcmd(height,6,cmdtext);
	return 0;
}

dcmd_offsetx(playerid, params[])
{
	new id, Float:amount;
	if (!sscanf(params, "df", amount)) SendClientMessage(playerid,0x554466AA,"Usage: /offsetx [textdraw id] [x pos(0.0)]");
	else if(writing || movingtext || lettersizing || boxsizing || saving) SendClientMessage(playerid,0x554466AA,"Complete the current operation first");
	else if(!textdrawactive[id])
		{
		SendClientMessage(playerid,0x554466AA,"The selected textdraw isn't avaible for edit, it wasn't created!");
		SendClientMessage(playerid,0x554466AA,"Please use /text if you aren't sure how to use this command.");
		}
	else 
		{
		textx[id]=amount;
		UpdateTextDraw(id,1);
		new tmp[256];
		format(tmp,256,"The x position of Textdraw number %d is now %f",id,amount);
		SendClientMessage(playerid,0x554466AA,tmp);
		}
	return 1;
}

dcmd_offsety(playerid, params[])
{
	new id, Float:amount;
	if (!sscanf(params, "df", amount)) SendClientMessage(playerid,0x554466AA,"Usage: /offsety [textdraw id] [y pos(0.0)]");
	else if(writing || movingtext || lettersizing || boxsizing || saving) SendClientMessage(playerid,0x554466AA,"Complete the current operation first");
	else if(!textdrawactive[id])
		{
		SendClientMessage(playerid,0x554466AA,"The selected textdraw isn't avaible for edit, it wasn't created!");
		SendClientMessage(playerid,0x554466AA,"Please use /text if you aren't sure how to use this command.");
		}
	else 
		{
		texty[id]=amount;
		UpdateTextDraw(id,1);
		new tmp[256];
		format(tmp,256,"The y position of Textdraw number %d is now %f",id,amount);
		SendClientMessage(playerid,0x554466AA,tmp);
		}
	return 1;
}

dcmd_moveleft(playerid, params[])
{
	new id, Float:amount;
	if (!sscanf(params, "df", amount)) SendClientMessage(playerid,0x554466AA,"Usage: /moveleft [textdraw id] [amount (0.0)]");
	else if(writing || movingtext || lettersizing || boxsizing || saving) SendClientMessage(playerid,0x554466AA,"Complete the current operation first");
	else if(!textdrawactive[id])
		{
		SendClientMessage(playerid,0x554466AA,"The selected textdraw isn't avaible for edit, it wasn't created!");
		SendClientMessage(playerid,0x554466AA,"Please use /text if you aren't sure how to use this command.");
		}
	else 
		{
		textx[id]-=amount;
		UpdateTextDraw(id,1);
		new tmp[256];
		format(tmp,256,"The Textdraw number %d got moved %f units to the left",id,amount);
		SendClientMessage(playerid,0x554466AA,tmp);
		}
	return 1;
}

dcmd_moveright(playerid, params[])
{
	new id, Float:amount;
	if (!sscanf(params, "df", amount)) SendClientMessage(playerid,0x554466AA,"Usage: /moveright [textdraw id] [amount (0.0)]");
	else if(writing || movingtext || lettersizing || boxsizing || saving) SendClientMessage(playerid,0x554466AA,"Complete the current operation first");
	else if(!textdrawactive[id])
		{
		SendClientMessage(playerid,0x554466AA,"The selected textdraw isn't avaible for edit, it wasn't created!");
		SendClientMessage(playerid,0x554466AA,"Please use /text if you aren't sure how to use this command.");
		}
	else 
		{
		textx[id]+=amount;
		UpdateTextDraw(id,1);
		new tmp[256];
		format(tmp,256,"The Textdraw number %d got moved %f units to the right",id,amount);
		SendClientMessage(playerid,0x554466AA,tmp);
		}
	return 1;
}

dcmd_moveup(playerid, params[])
{
	new id, Float:amount;
	if (!sscanf(params, "df", amount)) SendClientMessage(playerid,0x554466AA,"Usage: /moveup [textdraw id] [amount (0.0)]");
	else if(writing || movingtext || lettersizing || boxsizing || saving) SendClientMessage(playerid,0x554466AA,"Complete the current operation first");
	else if(!textdrawactive[id])
		{
		SendClientMessage(playerid,0x554466AA,"The selected textdraw isn't avaible for edit, it wasn't created!");
		SendClientMessage(playerid,0x554466AA,"Please use /text if you aren't sure how to use this command.");
		}
	else 
		{
		texty[id]-=amount;
		UpdateTextDraw(id,1);
		new tmp[256];
		format(tmp,256,"The Textdraw number %d got moved %f units to the up",id,amount);
		SendClientMessage(playerid,0x554466AA,tmp);
		}
	return 1;
}

dcmd_movedown(playerid, params[])
{
	new id, Float:amount;
	if (!sscanf(params, "df", amount)) SendClientMessage(playerid,0x554466AA,"Usage: /movedown [textdraw id] [amount (0.0)]");
	else if(writing || movingtext || lettersizing || boxsizing || saving) SendClientMessage(playerid,0x554466AA,"Complete the current operation first");
	else if(!textdrawactive[id])
		{
		SendClientMessage(playerid,0x554466AA,"The selected textdraw isn't avaible for edit, it wasn't created!");
		SendClientMessage(playerid,0x554466AA,"Please use /text if you aren't sure how to use this command.");
		}
	else 
		{
		texty[id]+=amount;
		UpdateTextDraw(id,1);
		new tmp[256];
		format(tmp,256,"The Textdraw number %d got moved %f units to the down",id,amount);
		SendClientMessage(playerid,0x554466AA,tmp);
		}
	return 1;
}

dcmd_width(playerid, params[])
{
	new id, Float:amount;
	if (!sscanf(params, "df", amount)) SendClientMessage(playerid,0x554466AA,"Usage: /width [textdraw id] [amount (0.0)]");
	else if(writing || movingtext || lettersizing || boxsizing || saving) SendClientMessage(playerid,0x554466AA,"Complete the current operation first");
	else if(!textdrawactive[id])
		{
		SendClientMessage(playerid,0x554466AA,"The selected textdraw isn't avaible for edit, it wasn't created!");
		SendClientMessage(playerid,0x554466AA,"Please use /text if you aren't sure how to use this command.");
		}
	else 
		{
		lettersizex[id]+=amount;
		UpdateTextDraw(id,0);
		new tmp[256];
		format(tmp,256,"The letter width of Textdraw number %d is now %f",id,amount);
		SendClientMessage(playerid,0x554466AA,tmp);
		}
	return 1;
}

dcmd_height(playerid, params[])
{
	new id, Float:amount;
	if (!sscanf(params, "df", amount)) SendClientMessage(playerid,0x554466AA,"Usage: /height [textdraw id] [amount (0.0)]");
	else if(writing || movingtext || lettersizing || boxsizing || saving) SendClientMessage(playerid,0x554466AA,"Complete the current operation first");
	else if(!textdrawactive[id])
		{
		SendClientMessage(playerid,0x554466AA,"The selected textdraw isn't avaible for edit, it wasn't created!");
		SendClientMessage(playerid,0x554466AA,"Please use /text if you aren't sure how to use this command.");
		}
	else 
		{
		lettersizey[id]+=amount;
		UpdateTextDraw(id,0);
		new tmp[256];
		format(tmp,256,"The letter height of Textdraw number %d is now %f",id,amount);
		SendClientMessage(playerid,0x554466AA,tmp);
		}
	return 1;
}

dcmd_edit(playerid, params[])
{
	new id;
	if (!sscanf(params, "i", id)) SendClientMessage(playerid,0x554466AA,"Usage: /edit [textdraw id]");
	else if(writing || movingtext || lettersizing || boxsizing || saving) SendClientMessage(playerid,0x554466AA,"Complete the current operation first");
	else if(!textdrawactive[id])
		{
		SendClientMessage(playerid,0x554466AA,"The selected textdraw isn't avaible for edit, it wasn't created!");
		SendClientMessage(playerid,0x554466AA,"Please use /text if you aren't sure how to use this command.");
		}
	else 
		{
		currtextdraw = id;
		new tmp[256];
		format(tmp,256,"The selected textdraw for edit now is the Textdraw %d",id);
		SendClientMessage(playerid,0x554466AA,tmp);
		menu=0;
		ShowMenuForPlayer(Main,playerid);
		}
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(writing)
		{
		format(textdrawtext[currtextdraw],256,"%s",text);
		TextDrawSetString(Textdraw[currtextdraw],textdrawtext[currtextdraw]);
		TogglePlayerControllable(playerid,1);
		SendClientMessage(playerid,0x554466AA,"Text sucessfully placed!");
		writing = 0;
		return 0;
		}
	if(saving)
		{
		SendClientMessage(playerid,0x554466AA,"Saving proccess started...");
		new tmp[256], str[256], File:gFile;
		format(str,256,"%s.txt",text);
		gFile = fopen(str, io_write);
		format(tmp,256,"//TextDraw developed using Zamaroht's in-game TextDraw system\r\n");
		fwrite(gFile,tmp);
		format(tmp,256," \r\n");
		fwrite(gFile,tmp);
		format(tmp,256,"//On top of script:\r\n");
		fwrite(gFile,tmp);
		for(new i;i<95;i++)
			{
			if(textdrawactive[i])
				{
				format(tmp,256,"new Text:Textdraw%d;\r\n",i);
				fwrite(gFile,tmp);
				}
			}
		format(tmp,256," \r\n");
		fwrite(gFile,tmp);
		format(tmp,256,"//In OnGameModeInit or any other place, we procced to create our textdraw:\r\n");
		fwrite(gFile,tmp);
		for(new i;i<95;i++)
			{
			if(textdrawactive[i])
				{
				format(tmp,256,"Textdraw%d = TextDrawCreate(%f,%f,\"%s\");\r\n",i,textx[i],texty[i],textdrawtext[i]);
				fwrite(gFile,tmp);
				}
			}
		for(new i;i<95;i++)
			{
			if(textdrawactive[i])
				{
				if(box[i])
					{
					format(tmp,256,"TextDrawUseBox(Textdraw%d,%d);\r\n",i,box[i]);
					fwrite(gFile,tmp);
					if(boxcolor[i]==red100) format(tmp,256,"TextdrawBoxColor(Textdraw%d,0xff0000ff);\r\n",i);
					else if(boxcolor[i]==blue100) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0x0000ffff);\r\n",i);
					else if(boxcolor[i]==green100) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0x00ff00ff);\r\n",i);
					else if(boxcolor[i]==yellow100) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0xffff00ff);\r\n",i);
					else if(boxcolor[i]==pink100) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0xff00ffff);\r\n",i);
					else if(boxcolor[i]==light_blue100) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0x00ffffff);\r\n",i);
					else if(boxcolor[i]==white100) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0xffffffff);\r\n",i);
					else if(boxcolor[i]==black100) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0x000000ff);\r\n",i);
					else if(boxcolor[i]==red80) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0xff0000cc);\r\n",i);
					else if(boxcolor[i]==blue80) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0x0000ffcc);\r\n",i);
					else if(boxcolor[i]==green80) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0x00ff00cc);\r\n",i);
					else if(boxcolor[i]==yellow80) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0xffff00cc);\r\n",i);
					else if(boxcolor[i]==pink80) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0xff00ffcc);\r\n",i);
					else if(boxcolor[i]==light_blue80) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0x00ffffcc);\r\n",i);
					else if(boxcolor[i]==white80) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0xffffffcc);\r\n",i);
					else if(boxcolor[i]==black80) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0x000000cc);\r\n",i);
					else if(boxcolor[i]==red60) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0xff000099);\r\n",i);
					else if(boxcolor[i]==blue60) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0x0000ff99);\r\n",i);
					else if(boxcolor[i]==green60) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0x00ff0099);\r\n",i);
					else if(boxcolor[i]==yellow60) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0xffff0099);\r\n",i);
					else if(boxcolor[i]==pink60) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0xff00ff99);\r\n",i);
					else if(boxcolor[i]==light_blue60) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0x00ffff99);\r\n",i);
					else if(boxcolor[i]==white60) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0xffffff99);\r\n",i);
					else if(boxcolor[i]==black60) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0x00000099);\r\n",i);
					else if(boxcolor[i]==red40) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0xff000066);\r\n",i);
					else if(boxcolor[i]==blue40) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0x0000ff66);\r\n",i);
					else if(boxcolor[i]==green40) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0x00ff0066);\r\n",i);
					else if(boxcolor[i]==yellow40) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0xffff0066);\r\n",i);
					else if(boxcolor[i]==pink40) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0xff00ff66);\r\n",i);
					else if(boxcolor[i]==light_blue40) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0x00ffff66);\r\n",i);
					else if(boxcolor[i]==white40) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0xffffff66);\r\n",i);
					else if(boxcolor[i]==black40) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0x00000066);\r\n",i);
					else if(boxcolor[i]==red20) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0xff000033);\r\n",i);
					else if(boxcolor[i]==blue20) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0x0000ff33);\r\n",i);
					else if(boxcolor[i]==green20) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0x00ff0033);\r\n",i);
					else if(boxcolor[i]==yellow20) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0xffff0033);\r\n",i);
					else if(boxcolor[i]==pink20) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0xff00ff33);\r\n",i);
					else if(boxcolor[i]==light_blue20) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0x00ffff33);\r\n",i);
					else if(boxcolor[i]==white20) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0xffffff33);\r\n",i);
					else if(boxcolor[i]==black20) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0x00000033);\r\n",i);
					else if(boxcolor[i]==red0) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0xff000000);\r\n",i);
					else if(boxcolor[i]==blue0) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0x0000ff00);\r\n",i);
					else if(boxcolor[i]==green0) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0x00ff0000);\r\n",i);
					else if(boxcolor[i]==yellow0) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0xffff0000);\r\n",i);
					else if(boxcolor[i]==pink0) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0xff00ff00);\r\n",i);
					else if(boxcolor[i]==light_blue0) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0x00ffff00);\r\n",i);
					else if(boxcolor[i]==white0) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0xffffff00);\r\n",i);
					else if(boxcolor[i]==black0) format(tmp,256,"TextDrawBoxColor(Textdraw%d,0x00000000);\r\n",i);
					fwrite(gFile,tmp);
					format(tmp,256,"TextDrawTextSize(Textdraw%d,%f,%f);\r\n",i,boxsizex[i],boxsizey[i]);
					fwrite(gFile,tmp);
					}
				}
			}
		for(new i;i<95;i++)
			{
			if(textdrawactive[i])
				{
				format(tmp,256,"TextDrawAlignment(Textdraw%d,%d);\r\n",i,alignment[i]);
				fwrite(gFile,tmp);
				}
			}
		for(new i;i<95;i++)
			{
			if(textdrawactive[i])
				{
				if(backcolor[i]==red100) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0xff0000ff);\r\n",i);
				else if(backcolor[i]==blue100) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0x0000ffff);\r\n",i);
				else if(backcolor[i]==green100) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0x00ff00ff);\r\n",i);
				else if(backcolor[i]==yellow100) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0xffff00ff);\r\n",i);
				else if(backcolor[i]==pink100) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0xff00ffff);\r\n",i);
				else if(backcolor[i]==light_blue100) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0x00ffffff);\r\n",i);
				else if(backcolor[i]==white100) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0xffffffff);\r\n",i);
				else if(backcolor[i]==black100) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0x000000ff);\r\n",i);
				else if(backcolor[i]==red80) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0xff0000cc);\r\n",i);
				else if(backcolor[i]==blue80) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0x0000ffcc);\r\n",i);
				else if(backcolor[i]==green80) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0x00ff00cc);\r\n",i);
				else if(backcolor[i]==yellow80) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0xffff00cc);\r\n",i);
				else if(backcolor[i]==pink80) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0xff00ffcc);\r\n",i);
				else if(backcolor[i]==light_blue80) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0x00ffffcc);\r\n",i);
				else if(backcolor[i]==white80) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0xffffffcc);\r\n",i);
				else if(backcolor[i]==black80) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0x000000cc);\r\n",i);
				else if(backcolor[i]==red60) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0xff000099);\r\n",i);
				else if(backcolor[i]==blue60) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0x0000ff99);\r\n",i);
				else if(backcolor[i]==green60) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0x00ff0099);\r\n",i);
				else if(backcolor[i]==yellow60) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0xffff0099);\r\n",i);
				else if(backcolor[i]==pink60) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0xff00ff99);\r\n",i);
				else if(backcolor[i]==light_blue60) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0x00ffff99);\r\n",i);
				else if(backcolor[i]==white60) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0xffffff99);\r\n",i);
				else if(backcolor[i]==black60) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0x00000099);\r\n",i);
				else if(backcolor[i]==red40) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0xff000066);\r\n",i);
				else if(backcolor[i]==blue40) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0x0000ff66);\r\n",i);
				else if(backcolor[i]==green40) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0x00ff0066);\r\n",i);
				else if(backcolor[i]==yellow40) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0xffff0066);\r\n",i);
				else if(backcolor[i]==pink40) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0xff00ff66);\r\n",i);
				else if(backcolor[i]==light_blue40) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0x00ffff66);\r\n",i);
				else if(backcolor[i]==white40) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0xffffff66);\r\n",i);
				else if(backcolor[i]==black40) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0x00000066);\r\n",i);
				else if(backcolor[i]==red20) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0xff000033);\r\n",i);
				else if(backcolor[i]==blue20) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0x0000ff33);\r\n",i);
				else if(backcolor[i]==green20) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0x00ff0033);\r\n",i);
				else if(backcolor[i]==yellow20) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0xffff0033);\r\n",i);
				else if(backcolor[i]==pink20) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0xff00ff33);\r\n",i);
				else if(backcolor[i]==light_blue20) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0x00ffff33);\r\n",i);
				else if(backcolor[i]==white20) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0xffffff33);\r\n",i);
				else if(backcolor[i]==black20) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0x00000033);\r\n",i);
				else if(backcolor[i]==red0) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0xff000000);\r\n",i);
				else if(backcolor[i]==blue0) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0x0000ff00);\r\n",i);
				else if(backcolor[i]==green0) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0x00ff0000);\r\n",i);
				else if(backcolor[i]==yellow0) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0xffff0000);\r\n",i);
				else if(backcolor[i]==pink0) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0xff00ff00);\r\n",i);
				else if(backcolor[i]==light_blue0) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0x00ffff00);\r\n",i);
				else if(backcolor[i]==white0) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0xffffff00);\r\n",i);
				else if(backcolor[i]==black0) format(tmp,256,"TextDrawBackgroundColor(Textdraw%d,0x00000000);\r\n",i);
				fwrite(gFile,tmp);
				}
			}
		for(new i;i<95;i++)
			{
			if(textdrawactive[i])
				{
				format(tmp,256,"TextDrawFont(Textdraw%d,%d);\r\n",i,font[i]);
				fwrite(gFile,tmp);
				format(tmp,256,"TextDrawLetterSize(Textdraw%d,%f,%f);\r\n",i,lettersizex[i],lettersizey[i]);
				fwrite(gFile,tmp);
				}
			}
		for(new i;i<95;i++)
			{
			if(textdrawactive[i])
				{
				if(textcolor[i]==red100) format(tmp,256,"TextDrawColor(Textdraw%d,0xff0000ff);\r\n",i);
				else if(textcolor[i]==blue100) format(tmp,256,"TextDrawColor(Textdraw%d,0x0000ffff);\r\n",i);
				else if(textcolor[i]==green100) format(tmp,256,"TextDrawColor(Textdraw%d,0x00ff00ff);\r\n",i);
				else if(textcolor[i]==yellow100) format(tmp,256,"TextDrawColor(Textdraw%d,0xffff00ff);\r\n",i);
				else if(textcolor[i]==pink100) format(tmp,256,"TextDrawColor(Textdraw%d,0xff00ffff);\r\n",i);
				else if(textcolor[i]==light_blue100) format(tmp,256,"TextDrawColor(Textdraw%d,0x00ffffff);\r\n",i);
				else if(textcolor[i]==white100) format(tmp,256,"TextDrawColor(Textdraw%d,0xffffffff);\r\n",i);
				else if(textcolor[i]==black100) format(tmp,256,"TextDrawColor(Textdraw%d,0x000000ff);\r\n",i);
				else if(textcolor[i]==red80) format(tmp,256,"TextDrawColor(Textdraw%d,0xff0000cc);\r\n",i);
				else if(textcolor[i]==blue80) format(tmp,256,"TextDrawColor(Textdraw%d,0x0000ffcc);\r\n",i);
				else if(textcolor[i]==green80) format(tmp,256,"TextDrawColor(Textdraw%d,0x00ff00cc);\r\n",i);
				else if(textcolor[i]==yellow80) format(tmp,256,"TextDrawColor(Textdraw%d,0xffff00cc);\r\n",i);
				else if(textcolor[i]==pink80) format(tmp,256,"TextDrawColor(Textdraw%d,0xff00ffcc);\r\n",i);
				else if(textcolor[i]==light_blue80) format(tmp,256,"TextDrawColor(Textdraw%d,0x00ffffcc);\r\n",i);
				else if(textcolor[i]==white80) format(tmp,256,"TextDrawColor(Textdraw%d,0xffffffcc);\r\n",i);
				else if(textcolor[i]==black80) format(tmp,256,"TextDrawColor(Textdraw%d,0x000000cc);\r\n",i);
				else if(textcolor[i]==red60) format(tmp,256,"TextDrawColor(Textdraw%d,0xff000099);\r\n",i);
				else if(textcolor[i]==blue60) format(tmp,256,"TextDrawColor(Textdraw%d,0x0000ff99);\r\n",i);
				else if(textcolor[i]==green60) format(tmp,256,"TextDrawColor(Textdraw%d,0x00ff0099);\r\n",i);
				else if(textcolor[i]==yellow60) format(tmp,256,"TextDrawColor(Textdraw%d,0xffff0099);\r\n",i);
				else if(textcolor[i]==pink60) format(tmp,256,"TextDrawColor(Textdraw%d,0xff00ff99);\r\n",i);
				else if(textcolor[i]==light_blue60) format(tmp,256,"TextDrawColor(Textdraw%d,0x00ffff99);\r\n",i);
				else if(textcolor[i]==white60) format(tmp,256,"TextDrawColor(Textdraw%d,0xffffff99);\r\n",i);
				else if(textcolor[i]==black60) format(tmp,256,"TextDrawColor(Textdraw%d,0x00000099);\r\n",i);
				else if(textcolor[i]==red40) format(tmp,256,"TextDrawColor(Textdraw%d,0xff000066);\r\n",i);
				else if(textcolor[i]==blue40) format(tmp,256,"TextDrawColor(Textdraw%d,0x0000ff66);\r\n",i);
				else if(textcolor[i]==green40) format(tmp,256,"TextDrawColor(Textdraw%d,0x00ff0066);\r\n",i);
				else if(textcolor[i]==yellow40) format(tmp,256,"TextDrawColor(Textdraw%d,0xffff0066);\r\n",i);
				else if(textcolor[i]==pink40) format(tmp,256,"TextDrawColor(Textdraw%d,0xff00ff66);\r\n",i);
				else if(textcolor[i]==light_blue40) format(tmp,256,"TextDrawColor(Textdraw%d,0x00ffff66);\r\n",i);
				else if(textcolor[i]==white40) format(tmp,256,"TextDrawColor(Textdraw%d,0xffffff66);\r\n",i);
				else if(textcolor[i]==black40) format(tmp,256,"TextDrawColor(Textdraw%d,0x00000066);\r\n",i);
				else if(textcolor[i]==red20) format(tmp,256,"TextDrawColor(Textdraw%d,0xff000033);\r\n",i);
				else if(textcolor[i]==blue20) format(tmp,256,"TextDrawColor(Textdraw%d,0x0000ff33);\r\n",i);
				else if(textcolor[i]==green20) format(tmp,256,"TextDrawColor(Textdraw%d,0x00ff0033);\r\n",i);
				else if(textcolor[i]==yellow20) format(tmp,256,"TextDrawColor(Textdraw%d,0xffff0033);\r\n",i);
				else if(textcolor[i]==pink20) format(tmp,256,"TextDrawColor(Textdraw%d,0xff00ff33);\r\n",i);
				else if(textcolor[i]==light_blue20) format(tmp,256,"TextDrawColor(Textdraw%d,0x00ffff33);\r\n",i);
				else if(textcolor[i]==white20) format(tmp,256,"TextDrawColor(Textdraw%d,0xffffff33);\r\n",i);
				else if(textcolor[i]==black20) format(tmp,256,"TextDrawColor(Textdraw%d,0x00000033);\r\n",i);
				else if(textcolor[i]==red0) format(tmp,256,"TextDrawColor(Textdraw%d,0xff000000);\r\n",i);
				else if(textcolor[i]==blue0) format(tmp,256,"TextDrawColor(Textdraw%d,0x0000ff00);\r\n",i);
				else if(textcolor[i]==green0) format(tmp,256,"TextDrawColor(Textdraw%d,0x00ff0000);\r\n",i);
				else if(textcolor[i]==yellow0) format(tmp,256,"TextDrawColor(Textdraw%d,0xffff0000);\r\n",i);
				else if(textcolor[i]==pink0) format(tmp,256,"TextDrawColor(Textdraw%d,0xff00ff00);\r\n",i);
				else if(textcolor[i]==light_blue0) format(tmp,256,"TextDrawColor(Textdraw%d,0x00ffff00);\r\n",i);
				else if(textcolor[i]==white0) format(tmp,256,"TextDrawColor(Textdraw%d,0xffffff00);\r\n",i);
				else if(textcolor[i]==black0) format(tmp,256,"TextDrawColor(Textdraw%d,0x00000000);\r\n",i);
				fwrite(gFile,tmp);
				}
			}
		for(new i;i<95;i++)
			{
			if(textdrawactive[i])
				{
				if(outline[i])
					{
					format(tmp,256,"TextDrawSetOutline(Textdraw%d,%d);\r\n",i,outline[i]);
					fwrite(gFile,tmp);
					}
				}
			}
		for(new i;i<95;i++)
			{
			if(textdrawactive[i])
				{
				if(proportional[i])
					{
					format(tmp,256,"TextDrawSetProportional(Textdraw%d,%d);\r\n",i,proportional[i]);
					fwrite(gFile,tmp);
					}
				}
			}
		for(new i;i<95;i++)
			{
			if(textdrawactive[i])
				{
				if(shadow[i])
					{
					format(tmp,256,"TextDrawSetShadow(Textdraw%d,%d);\r\n",i,shadow[i]);
					fwrite(gFile,tmp);
					}
				}
			}
		format(tmp,256," \r\n");
		fwrite(gFile,tmp);
		format(tmp,256,"//You can now use TextDrawShowForPlayer(-ForAll), TextDrawHideForPlayer(-ForAll) and\r\n");
		fwrite(gFile,tmp);
		format(tmp,256,"//TextDrawDestroy functions to show, hide, and destroy the textdraw.\r\n");
		fwrite(gFile,tmp);
		format(tmp,256," \r\n");
		fwrite(gFile,tmp);
		fwrite(gFile,tmp);
		fclose(gFile);
		TogglePlayerControllable(playerid,1);
		new str2[256];
		format(str2,256,"TextDraw successfully saved on file '%s'",str);
		SendClientMessage(playerid,0x554466AA,str2);
		TogglePlayerControllable(playerid,1);
		saving=0;
		return 0;
		}
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	if(menu >= 100 && menu <= 109)
		{
		switch(row)
			{
			case 0:
				{
				if(menu==100)
					{
					new tmp;
					for(new i;i<95;i++)
						{
						if(!textdrawactive[i])
							{
							tmp=i;
							i+=100;
							}
						}
					textdrawactive[tmp]=1;
					currtextdraw=tmp;
					ShowMenuForPlayer(Main,playerid);
					TextDrawShowForAll(Textdraw[tmp]);
					menu=0;
					}
				else
					{
					if(menu==101) ShowMenuForPlayer(PreMain,playerid);
					if(menu==102) ShowMenuForPlayer(PreMain2,playerid);
					if(menu==103) ShowMenuForPlayer(PreMain3,playerid);
					if(menu==104) ShowMenuForPlayer(PreMain4,playerid);
					if(menu==105) ShowMenuForPlayer(PreMain5,playerid);
					if(menu==106) ShowMenuForPlayer(PreMain6,playerid);
					if(menu==107) ShowMenuForPlayer(PreMain7,playerid);
					if(menu==108) ShowMenuForPlayer(PreMain8,playerid);
					if(menu==109) ShowMenuForPlayer(PreMain9,playerid);
					menu--;
					}
				}
			case 11:
				{
				if(menu==100) ShowMenuForPlayer(PreMain2,playerid);
				if(menu==101) ShowMenuForPlayer(PreMain3,playerid);
				if(menu==102) ShowMenuForPlayer(PreMain4,playerid);
				if(menu==103) ShowMenuForPlayer(PreMain5,playerid);
				if(menu==104) ShowMenuForPlayer(PreMain6,playerid);
				if(menu==105) ShowMenuForPlayer(PreMain7,playerid);
				if(menu==106) ShowMenuForPlayer(PreMain8,playerid);
				if(menu==107) ShowMenuForPlayer(PreMain9,playerid);
				if(menu==108) ShowMenuForPlayer(PreMain10,playerid);
				menu++;
				}
			default:
				{
				if(textdrawactive[(menu-100)*10+row-1])
					{
					currtextdraw=(menu-100)*10+row-1;
					ShowMenuForPlayer(Main,playerid);
					menu=0;
					}
				else
					{
					SendClientMessage(playerid,0x554466AA,"The selected Textdraw isn't created, please select again");
					TogglePlayerControllable(playerid,1);
					}
				}
			}
		if(IsValidMenu(PreMain)) DestroyMenu(PreMain);
		if(IsValidMenu(PreMain2)) DestroyMenu(PreMain2);
		if(IsValidMenu(PreMain3)) DestroyMenu(PreMain3);
		if(IsValidMenu(PreMain4)) DestroyMenu(PreMain4);
		if(IsValidMenu(PreMain5)) DestroyMenu(PreMain5);
		if(IsValidMenu(PreMain6)) DestroyMenu(PreMain6);
		if(IsValidMenu(PreMain7)) DestroyMenu(PreMain7);
		if(IsValidMenu(PreMain8)) DestroyMenu(PreMain8);
		if(IsValidMenu(PreMain9)) DestroyMenu(PreMain9);
		if(IsValidMenu(PreMain10)) DestroyMenu(PreMain10);
		}
	else if(menu==0)
		{
		switch(row)
			{
			case 0:
				{
				SendClientMessage(playerid,0x554466AA,"Press T or F6, write the text and press enter");
				writing=1;
				}
			case 1:
				{
				SendClientMessage(playerid,0x554466AA,"Use 'Crouch'(-y), 'Jump'(+y), 'Look Behind'(-x) and 'Walk'(+x) keys to move it");
				SendClientMessage(playerid,0x554466AA,"(+ Sprint Key to move faster), TAB to finish");
				movingtext=1;
				}
			case 2:
				{
				SendClientMessage(playerid,0x554466AA,"Use 'Crouch'(-y), 'Jump'(+y), 'Look Behind'(-x) and 'Walk'(+x) keys to change it");
				SendClientMessage(playerid,0x554466AA,"(+ Sprint Key to change faster), TAB to finish");
				lettersizing=1;
				}
			case 3:
				{
				ShowMenuForPlayer(AlignmentM,playerid);
				menu = 1;
				}
			case 4:
				{
				ShowMenuForPlayer(ColorM,playerid);
				menu = 2;
				}
			case 5:
				{
				ShowMenuForPlayer(Box1M,playerid);
				menu = 4;
				}
			case 6:
				{
				ShowMenuForPlayer(ColorM,playerid);
				menu = 7;
				}
			case 7:
				{
				ShowMenuForPlayer(ShadowM,playerid);
				menu = 9;
				}
			case 8:
				{
				ShowMenuForPlayer(ProportionalM,playerid);
				menu = 10;
				}
			case 9:
				{
				ShowMenuForPlayer(FontM,playerid);
				menu = 11;
				}
			case 10:
				{
				ShowMenuForPlayer(OutlineM,playerid);
				menu = 12;
				}
			case 11:
				{
				ShowMenuForPlayer(Main2,playerid);
				menu = 20;
				}
			}
		}
	else if(menu==20)
		{
		switch(row)
			{
			case 0:
				{
				ShowMenuForPlayer(Main,playerid);
				menu = 0;
				}
			case 1:
				{
				SendClientMessage(playerid,0x554466AA,"Now write a name for the file, which will be saved on scriptfiles folder with .txt extension");
				SendClientMessage(playerid,0x554466AA,"automatly added. If the file already exists, it will be overwrited without warning.");
				saving=1;
				}
			case 2:
				{
				textdrawactive[currtextdraw]=0;
				TextDrawHideForAll(Textdraw[currtextdraw]);
				textdrawtext[currtextdraw] = " ";
				textx[currtextdraw] = 1.0;
				texty[currtextdraw] = 1.0;
				lettersizex[currtextdraw] = 1.0;
				lettersizey[currtextdraw] = 1.0;
				boxsizex[currtextdraw] = 0.0;
				boxsizey[currtextdraw] = 0.0;
				alignment[currtextdraw]= 0;
				box[currtextdraw] = 0;
				boxcolor[currtextdraw] = 0x000000FF;
				backcolor[currtextdraw] = 0x000000FF;
				proportional[currtextdraw] = 1;
				font[currtextdraw] = 3;
				shadow[currtextdraw] = 1;
				outline[currtextdraw] = 1;
				textcolor[currtextdraw] = 0xFFFFFFFF;
				HideMenuForPlayer(Main,playerid);
				SendClientMessage(playerid,0x554466AA,"Textdraw deleted.");
				TogglePlayerControllable(playerid,1);
				}
			}
		}
	else if(menu==1)
		{
		switch(row)
			{
			case 0:
				{
				alignment[currtextdraw]=0;
				TextDrawAlignment(Textdraw[currtextdraw], 0);
				menu=0;
				TogglePlayerControllable(playerid,1);
				SendClientMessage(playerid,0x554466AA,"Done");
				}
			case 1:
				{
				alignment[currtextdraw]=1;
				TextDrawAlignment(Textdraw[currtextdraw], 1);
				menu=0;
				TogglePlayerControllable(playerid,1);
				SendClientMessage(playerid,0x554466AA,"Done");
				}
			case 2:
				{
				alignment[currtextdraw]=2;
				TextDrawAlignment(Textdraw[currtextdraw], 2);
				menu=0;
				TogglePlayerControllable(playerid,1);
				SendClientMessage(playerid,0x554466AA,"Done");
				}
			case 3:
				{
				alignment[currtextdraw]=3;
				TextDrawAlignment(Textdraw[currtextdraw], 3);
				menu=0;
				TogglePlayerControllable(playerid,1);
				SendClientMessage(playerid,0x554466AA,"Done");
				}
			}
		}
	else if(menu==2)
		{
		switch(row)
			{
			case 0:
				{
				color=red;
				ShowMenuForPlayer(TransparencyM, playerid);
				menu=3;
				}
			case 1:
				{
				color=blue;
				ShowMenuForPlayer(TransparencyM, playerid);
				menu=3;
				}
			case 2:
				{
				color=green;
				ShowMenuForPlayer(TransparencyM, playerid);
				menu=3;
				}
			case 3:
				{
				color=yellow;
				ShowMenuForPlayer(TransparencyM, playerid);
				menu=3;
				}
			case 4:
				{
				color=pink;
				ShowMenuForPlayer(TransparencyM, playerid);
				menu=3;
				}
			case 5:
				{
				color=light_blue;
				ShowMenuForPlayer(TransparencyM, playerid);
				menu=3;
				}
			case 6:
				{
				color=white;
				ShowMenuForPlayer(TransparencyM, playerid);
				menu=3;
				}
			case 7:
				{
				color=black;
				ShowMenuForPlayer(TransparencyM, playerid);
				menu=3;
				}
			}
		}
	else if(menu==3)
		{
		switch(row)
			{
			case 0:
				{
				switch(color)
					{
					case red: textcolor[currtextdraw]=red100;
					case blue: textcolor[currtextdraw]=blue100;
					case green: textcolor[currtextdraw]=green100;
					case yellow: textcolor[currtextdraw]=yellow100;
					case pink: textcolor[currtextdraw]=pink100;
					case light_blue: textcolor[currtextdraw]=light_blue100;
					case white: textcolor[currtextdraw]=white100;
					case black: textcolor[currtextdraw]=black100;
					}
				}
			case 1:
				{
				switch(color)
					{
					case red: textcolor[currtextdraw]=red80;
					case blue: textcolor[currtextdraw]=blue80;
					case green: textcolor[currtextdraw]=green80;
					case yellow: textcolor[currtextdraw]=yellow80;
					case pink: textcolor[currtextdraw]=pink80;
					case light_blue: textcolor[currtextdraw]=light_blue80;
					case white: textcolor[currtextdraw]=white80;
					case black: textcolor[currtextdraw]=black80;
					}
				}
			case 2:
				{
				switch(color)
					{
					case red: textcolor[currtextdraw]=red60;
					case blue: textcolor[currtextdraw]=blue60;
					case green: textcolor[currtextdraw]=green60;
					case yellow: textcolor[currtextdraw]=yellow60;
					case pink: textcolor[currtextdraw]=pink60;
					case light_blue: textcolor[currtextdraw]=light_blue60;
					case white: textcolor[currtextdraw]=white60;
					case black: textcolor[currtextdraw]=black60;
					}
				}
			case 3:
				{
				switch(color)
					{
					case red: textcolor[currtextdraw]=red40;
					case blue: textcolor[currtextdraw]=blue40;
					case green: textcolor[currtextdraw]=green40;
					case yellow: textcolor[currtextdraw]=yellow40;
					case pink: textcolor[currtextdraw]=pink40;
					case light_blue: textcolor[currtextdraw]=light_blue40;
					case white: textcolor[currtextdraw]=white40;
					case black: textcolor[currtextdraw]=black40;
					}
				}
			case 4:
				{
				switch(color)
					{
					case red: textcolor[currtextdraw]=red20;
					case blue: textcolor[currtextdraw]=blue20;
					case green: textcolor[currtextdraw]=green20;
					case yellow: textcolor[currtextdraw]=yellow20;
					case pink: textcolor[currtextdraw]=pink20;
					case light_blue: textcolor[currtextdraw]=light_blue20;
					case white: textcolor[currtextdraw]=white20;
					case black: textcolor[currtextdraw]=black20;
					}
				}
			case 5:
				{
				switch(color)
					{
					case red: textcolor[currtextdraw]=red0;
					case blue: textcolor[currtextdraw]=blue0;
					case green: textcolor[currtextdraw]=green0;
					case yellow: textcolor[currtextdraw]=yellow0;
					case pink: textcolor[currtextdraw]=pink0;
					case light_blue: textcolor[currtextdraw]=light_blue0;
					case white: textcolor[currtextdraw]=white0;
					case black: textcolor[currtextdraw]=black0;
					}
				}
			}
		UpdateTextDraw(currtextdraw,0);
		TogglePlayerControllable(playerid,1);
		menu=0;
		SendClientMessage(playerid,0x554466AA,"Color Applied");
		}
	else if(menu==4)
		{
		switch(row)
			{
			case 0:
				{
				box[currtextdraw]=1;
				UpdateTextDraw(currtextdraw,0);
				SendClientMessage(playerid,0x554466AA,"Use 'Crouch'(-y), 'Jump'(+y), 'Look Behind'(-x) and 'Walk'(+x) keys to change the box size");
				SendClientMessage(playerid,0x554466AA,"(+ Sprint Key to move faster), TAB to finish");
				boxsizing=1;
				}
			case 1:
				{
				box[currtextdraw]=0;
				UpdateTextDraw(currtextdraw,0);
				TogglePlayerControllable(playerid,1);
				menu=0;
				SendClientMessage(playerid,0x554466AA,"Box disabled");
				}
			}
		}
	else if(menu==5)
		{
		switch(row)
			{
			case 0:
				{
				color=red;
				ShowMenuForPlayer(TransparencyM, playerid);
				menu=6;
				}
			case 1:
				{
				color=blue;
				ShowMenuForPlayer(TransparencyM, playerid);
				menu=6;
				}
			case 2:
				{
				color=green;
				ShowMenuForPlayer(TransparencyM, playerid);
				menu=6;
				}
			case 3:
				{
				color=yellow;
				ShowMenuForPlayer(TransparencyM, playerid);
				menu=6;
				}
			case 4:
				{
				color=pink;
				ShowMenuForPlayer(TransparencyM, playerid);
				menu=6;
				}
			case 5:
				{
				color=light_blue;
				ShowMenuForPlayer(TransparencyM, playerid);
				menu=6;
				}
			case 6:
				{
				color=white;
				ShowMenuForPlayer(TransparencyM, playerid);
				menu=6;
				}
			case 7:
				{
				color=black;
				ShowMenuForPlayer(TransparencyM, playerid);
				menu=6;
				}
			}
		}
	else if(menu==6)
		{
		switch(row)
			{
			case 0:
				{
				switch(color)
					{
					case red: boxcolor[currtextdraw]=red100;
					case blue: boxcolor[currtextdraw]=blue100;
					case green: boxcolor[currtextdraw]=green100;
					case yellow: boxcolor[currtextdraw]=yellow100;
					case pink: boxcolor[currtextdraw]=pink100;
					case light_blue: boxcolor[currtextdraw]=light_blue100;
					case white: boxcolor[currtextdraw]=white100;
					case black: boxcolor[currtextdraw]=black100;
					}
				}
			case 1:
				{
				switch(color)
					{
					case red: boxcolor[currtextdraw]=red80;
					case blue: boxcolor[currtextdraw]=blue80;
					case green: boxcolor[currtextdraw]=green80;
					case yellow: boxcolor[currtextdraw]=yellow80;
					case pink: boxcolor[currtextdraw]=pink80;
					case light_blue: boxcolor[currtextdraw]=light_blue80;
					case white: boxcolor[currtextdraw]=white80;
					case black: boxcolor[currtextdraw]=black80;
					}
				}
			case 2:
				{
				switch(color)
					{
					case red: boxcolor[currtextdraw]=red60;
					case blue: boxcolor[currtextdraw]=blue60;
					case green: boxcolor[currtextdraw]=green60;
					case yellow: boxcolor[currtextdraw]=yellow60;
					case pink: boxcolor[currtextdraw]=pink60;
					case light_blue: boxcolor[currtextdraw]=light_blue60;
					case white: boxcolor[currtextdraw]=white60;
					case black: boxcolor[currtextdraw]=black60;
					}
				}
			case 3:
				{
				switch(color)
					{
					case red: boxcolor[currtextdraw]=red40;
					case blue: boxcolor[currtextdraw]=blue40;
					case green: boxcolor[currtextdraw]=green40;
					case yellow: boxcolor[currtextdraw]=yellow40;
					case pink: boxcolor[currtextdraw]=pink40;
					case light_blue: boxcolor[currtextdraw]=light_blue40;
					case white: boxcolor[currtextdraw]=white40;
					case black: boxcolor[currtextdraw]=black40;
					}
				}
			case 4:
				{
				switch(color)
					{
					case red: boxcolor[currtextdraw]=red20;
					case blue: boxcolor[currtextdraw]=blue20;
					case green: boxcolor[currtextdraw]=green20;
					case yellow: boxcolor[currtextdraw]=yellow20;
					case pink: boxcolor[currtextdraw]=pink20;
					case light_blue: boxcolor[currtextdraw]=light_blue20;
					case white: boxcolor[currtextdraw]=white20;
					case black: boxcolor[currtextdraw]=black20;
					}
				}
			case 5:
				{
				switch(color)
					{
					case red: boxcolor[currtextdraw]=red0;
					case blue: boxcolor[currtextdraw]=blue0;
					case green: boxcolor[currtextdraw]=green0;
					case yellow: boxcolor[currtextdraw]=yellow0;
					case pink: boxcolor[currtextdraw]=pink0;
					case light_blue: boxcolor[currtextdraw]=light_blue0;
					case white: boxcolor[currtextdraw]=white0;
					case black: boxcolor[currtextdraw]=black0;
					}
				}
			}
		UpdateTextDraw(currtextdraw,0);
		TogglePlayerControllable(playerid,1);
		menu=0;
		SendClientMessage(playerid,0x554466AA,"Color applied, box customization successful!");
		}
	else if(menu==7)
		{
		switch(row)
			{
			case 0:
				{
				color=red;
				ShowMenuForPlayer(TransparencyM, playerid);
				menu=8;
				}
			case 1:
				{
				color=blue;
				ShowMenuForPlayer(TransparencyM, playerid);
				menu=8;
				}
			case 2:
				{
				color=green;
				ShowMenuForPlayer(TransparencyM, playerid);
				menu=8;
				}
			case 3:
				{
				color=yellow;
				ShowMenuForPlayer(TransparencyM, playerid);
				menu=8;
				}
			case 4:
				{
				color=pink;
				ShowMenuForPlayer(TransparencyM, playerid);
				menu=8;
				}
			case 5:
				{
				color=light_blue;
				ShowMenuForPlayer(TransparencyM, playerid);
				menu=8;
				}
			case 6:
				{
				color=white;
				ShowMenuForPlayer(TransparencyM, playerid);
				menu=8;
				}
			case 7:
				{
				color=black;
				ShowMenuForPlayer(TransparencyM, playerid);
				menu=8;
				}
			}
		}
	else if(menu==8)
		{
		switch(row)
			{
			case 0:
				{
				switch(color)
					{
					case red: backcolor[currtextdraw]=red100;
					case blue: backcolor[currtextdraw]=blue100;
					case green: backcolor[currtextdraw]=green100;
					case yellow: backcolor[currtextdraw]=yellow100;
					case pink: backcolor[currtextdraw]=pink100;
					case light_blue: backcolor[currtextdraw]=light_blue100;
					case white: backcolor[currtextdraw]=white100;
					case black: backcolor[currtextdraw]=black100;
					}
				}
			case 1:
				{
				switch(color)
					{
					case red: backcolor[currtextdraw]=red80;
					case blue: backcolor[currtextdraw]=blue80;
					case green: backcolor[currtextdraw]=green80;
					case yellow: backcolor[currtextdraw]=yellow80;
					case pink: backcolor[currtextdraw]=pink80;
					case light_blue: backcolor[currtextdraw]=light_blue80;
					case white: backcolor[currtextdraw]=white80;
					case black: backcolor[currtextdraw]=black80;
					}
				}
			case 2:
				{
				switch(color)
					{
					case red: backcolor[currtextdraw]=red60;
					case blue: backcolor[currtextdraw]=blue60;
					case green: backcolor[currtextdraw]=green60;
					case yellow: backcolor[currtextdraw]=yellow60;
					case pink: backcolor[currtextdraw]=pink60;
					case light_blue: backcolor[currtextdraw]=light_blue60;
					case white: backcolor[currtextdraw]=white60;
					case black: backcolor[currtextdraw]=black60;
					}
				}
			case 3:
				{
				switch(color)
					{
					case red: backcolor[currtextdraw]=red40;
					case blue: backcolor[currtextdraw]=blue40;
					case green: backcolor[currtextdraw]=green40;
					case yellow: backcolor[currtextdraw]=yellow40;
					case pink: backcolor[currtextdraw]=pink40;
					case light_blue: backcolor[currtextdraw]=light_blue40;
					case white: backcolor[currtextdraw]=white40;
					case black: backcolor[currtextdraw]=black40;
					}
				}
			case 4:
				{
				switch(color)
					{
					case red: backcolor[currtextdraw]=red20;
					case blue: backcolor[currtextdraw]=blue20;
					case green: backcolor[currtextdraw]=green20;
					case yellow: backcolor[currtextdraw]=yellow20;
					case pink: backcolor[currtextdraw]=pink20;
					case light_blue: backcolor[currtextdraw]=light_blue20;
					case white: backcolor[currtextdraw]=white20;
					case black: backcolor[currtextdraw]=black20;
					}
				}
			case 5:
				{
				switch(color)
					{
					case red: backcolor[currtextdraw]=red0;
					case blue: backcolor[currtextdraw]=blue0;
					case green: backcolor[currtextdraw]=green0;
					case yellow: backcolor[currtextdraw]=yellow0;
					case pink: backcolor[currtextdraw]=pink0;
					case light_blue: backcolor[currtextdraw]=light_blue0;
					case white: backcolor[currtextdraw]=white0;
					case black: backcolor[currtextdraw]=black0;
					}
				}
			}
		UpdateTextDraw(currtextdraw,0);
		TogglePlayerControllable(playerid,1);
		menu=0;
		SendClientMessage(playerid,0x554466AA,"Color applied, box customization successful!");
		}
	else if(menu==9)
		{
		switch(row)
			{
			case 0: shadow[currtextdraw]=0;
			case 1: shadow[currtextdraw]=1;
			case 2: shadow[currtextdraw]=2;
			case 3: shadow[currtextdraw]=3;
			case 4: shadow[currtextdraw]=4;
			case 5: shadow[currtextdraw]=5;
			case 6: shadow[currtextdraw]=6;
			case 7: shadow[currtextdraw]=7;
			case 8: shadow[currtextdraw]=8;
			case 9: shadow[currtextdraw]=9;
			case 10: shadow[currtextdraw]=10;
			}
		UpdateTextDraw(currtextdraw,0);
		TogglePlayerControllable(playerid,1);
		menu=0;
		SendClientMessage(playerid,0x554466AA,"Shadow applied");
		}
	else if(menu==10)
		{
		switch(row)
			{
			case 0: proportional[currtextdraw]=0;
			case 1: proportional[currtextdraw]=1;
			}
		UpdateTextDraw(currtextdraw,0);
		TogglePlayerControllable(playerid,1);
		menu=0;
		SendClientMessage(playerid,0x554466AA,"Done");
		}
	else if(menu==11)
		{
		switch(row)
			{
			case 0: font[currtextdraw]=0;
			case 1: font[currtextdraw]=1;
			case 2: font[currtextdraw]=2;
			case 3: font[currtextdraw]=3;
			}
		UpdateTextDraw(currtextdraw,0);
		TogglePlayerControllable(playerid,1);
		menu=0;
		SendClientMessage(playerid,0x554466AA,"Font successfully changed");
		}
	else if(menu==12)
		{
		switch(row)
			{
			case 0: outline[currtextdraw]=0;
			case 1: outline[currtextdraw]=1;
			}
		UpdateTextDraw(currtextdraw,0);
		TogglePlayerControllable(playerid,1);
		menu=0;
		SendClientMessage(playerid,0x554466AA,"Changes applied");
		}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(movingtext && newkeys == KEY_WALK && textx[currtextdraw] <= 640.0)
		{
		textx[currtextdraw]+=1.0;
		UpdateTextDraw(currtextdraw,1);
		}
	if(movingtext && newkeys == KEY_LOOK_BEHIND && textx[currtextdraw] >= 0.0)
		{
		textx[currtextdraw]-=1.0;
		UpdateTextDraw(currtextdraw,1);
		}
	if(movingtext && newkeys == KEY_JUMP && texty[currtextdraw] >= 0.0)
		{
		texty[currtextdraw]-=1.0;
		UpdateTextDraw(currtextdraw,1);
		}
	if(movingtext && newkeys == KEY_CROUCH && texty[currtextdraw] <= 480.0)
		{
		texty[currtextdraw]+=1.0;
		UpdateTextDraw(currtextdraw,1);
		}
	if(movingtext && newkeys == KEY_WALK+KEY_SPRINT && textx[currtextdraw] <= 640.0)
		{
		textx[currtextdraw]+=10.0;
		UpdateTextDraw(currtextdraw,1);
		}
	if(movingtext && newkeys == KEY_LOOK_BEHIND+KEY_SPRINT && textx[currtextdraw] >= 0.0)
		{
		textx[currtextdraw]-=10.0;
		UpdateTextDraw(currtextdraw,1);
		}
	if(movingtext && newkeys == KEY_JUMP+KEY_SPRINT && texty[currtextdraw] >= 0.0)
		{
		texty[currtextdraw]-=10.0;
		UpdateTextDraw(currtextdraw,1);
		}
	if(movingtext && newkeys == KEY_CROUCH+KEY_SPRINT && texty[currtextdraw] <= 480.0)
		{
		texty[currtextdraw]+=10.0;
		UpdateTextDraw(currtextdraw,1);
		}
	if(movingtext && newkeys == KEY_ACTION)
		{
		SendClientMessage(playerid,0x554466AA,"Text sucessfully placed!");
		TogglePlayerControllable(playerid,1);
		movingtext=0;
		}
	if(lettersizing && newkeys == KEY_WALK && textx[currtextdraw] <= 640.0)
		{
		lettersizex[currtextdraw]+=0.1;
		UpdateTextDraw(currtextdraw,0);
		}
	if(lettersizing && newkeys == KEY_LOOK_BEHIND && textx[currtextdraw] >= 0.0)
		{
		lettersizex[currtextdraw]-=0.1;
		UpdateTextDraw(currtextdraw,0);
		}
	if(lettersizing && newkeys == KEY_JUMP && texty[currtextdraw] >= 0.0)
		{
		lettersizey[currtextdraw]-=0.1;
		UpdateTextDraw(currtextdraw,0);
		}
	if(lettersizing && newkeys == KEY_CROUCH && texty[currtextdraw] <= 480.0)
		{
		lettersizey[currtextdraw]+=0.1;
		UpdateTextDraw(currtextdraw,0);
		}
	if(lettersizing && newkeys == KEY_WALK+KEY_SPRINT && textx[currtextdraw] <= 640.0)
		{
		lettersizex[currtextdraw]+=1.0;
		UpdateTextDraw(currtextdraw,0);
		}
	if(lettersizing && newkeys == KEY_LOOK_BEHIND+KEY_SPRINT && textx[currtextdraw] >= 0.0)
		{
		lettersizex[currtextdraw]-=1.0;
		UpdateTextDraw(currtextdraw,0);
		}
	if(lettersizing && newkeys == KEY_JUMP+KEY_SPRINT && texty[currtextdraw] >= 0.0)
		{
		lettersizey[currtextdraw]-=1.0;
		UpdateTextDraw(currtextdraw,0);
		}
	if(lettersizing && newkeys == KEY_CROUCH+KEY_SPRINT && texty[currtextdraw] <= 480.0)
		{
		lettersizey[currtextdraw]+=1.0;
		UpdateTextDraw(currtextdraw,0);
		}
	if(lettersizing && newkeys == KEY_ACTION)
		{
		SendClientMessage(playerid,0x554466AA,"Text sucessfully placed!");
		TogglePlayerControllable(playerid,1);
		lettersizing=0;
		}
	if(boxsizing && newkeys == KEY_WALK && textx[currtextdraw] <= 640.0)
		{
		boxsizex[currtextdraw]+=1.0;
		UpdateTextDraw(currtextdraw,0);
		}
	if(boxsizing && newkeys == KEY_LOOK_BEHIND && textx[currtextdraw] >= 0.0)
		{
		boxsizex[currtextdraw]-=1.0;
		UpdateTextDraw(currtextdraw,0);
		}
	if(boxsizing && newkeys == KEY_JUMP && texty[currtextdraw] >= 0.0)
		{
		boxsizey[currtextdraw]-=1.0;
		UpdateTextDraw(currtextdraw,0);
		}
	if(boxsizing && newkeys == KEY_CROUCH && texty[currtextdraw] <= 480.0)
		{
		boxsizey[currtextdraw]+=1.0;
		UpdateTextDraw(currtextdraw,0);
		}
	if(boxsizing && newkeys == KEY_WALK+KEY_SPRINT && textx[currtextdraw] <= 640.0)
		{
		boxsizex[currtextdraw]+=10.0;
		UpdateTextDraw(currtextdraw,0);
		}
	if(boxsizing && newkeys == KEY_LOOK_BEHIND+KEY_SPRINT && textx[currtextdraw] >= 0.0)
		{
		boxsizex[currtextdraw]-=10.0;
		UpdateTextDraw(currtextdraw,0);
		}
	if(boxsizing && newkeys == KEY_JUMP+KEY_SPRINT && texty[currtextdraw] >= 0.0)
		{
		boxsizey[currtextdraw]-=10.0;
		UpdateTextDraw(currtextdraw,0);
		}
	if(boxsizing && newkeys == KEY_CROUCH+KEY_SPRINT && texty[currtextdraw] <= 480.0)
		{
		boxsizey[currtextdraw]+=10.0;
		UpdateTextDraw(currtextdraw,0);
		}
	if(boxsizing && newkeys == KEY_ACTION)
		{
		SendClientMessage(playerid,0x554466AA,"Box size successfully changed, changing color");
		boxsizing=0;
		menu=5;
		ShowMenuForPlayer(ColorM,playerid);
		}
	return 1;
}
	
public OnPlayerExitedMenu(playerid)
{
	TogglePlayerControllable(playerid, 1);
	SendClientMessage(playerid,0x554466AA,"Selection has been canceled");
	menu=0;
	return 1;
}

UpdateTextDraw(curr,destroy)
{
	TextDrawHideForAll(Textdraw[curr]);
	if(destroy)
		{
		TextDrawDestroy(Textdraw[curr]);
		Textdraw[curr] = TextDrawCreate(textx[curr],texty[curr],textdrawtext[curr]);
		}
	TextDrawUseBox(Textdraw[curr],box[curr]);
	if(box[curr])
		{
		TextDrawBoxColor(Textdraw[curr], boxcolor[curr]);
		TextDrawTextSize(Textdraw[curr], boxsizex[curr], boxsizey[curr]);
		}
	TextDrawSetString(Textdraw[curr],textdrawtext[curr]);
	TextDrawAlignment(Textdraw[curr],alignment[curr]);
	TextDrawBackgroundColor(Textdraw[curr],backcolor[curr]);
	TextDrawColor(Textdraw[curr], textcolor[curr]);
	TextDrawFont(Textdraw[curr],font[curr]);
	TextDrawLetterSize(Textdraw[curr],lettersizex[curr],lettersizey[curr]);
	TextDrawSetOutline(Textdraw[curr],outline[curr]);
	TextDrawSetProportional(Textdraw[curr],proportional[curr]);
	TextDrawSetShadow(Textdraw[curr],shadow[curr]);
	TextDrawShowForAll(Textdraw[curr]);
}

sscanf(string[], format[], {Float,_}:...)
{
	new
		formatPos,
		stringPos,
		paramPos = 2,
		paramCount = numargs();
	while (paramPos < paramCount && string[stringPos])
	{
		switch (format[formatPos])
		{
			case '\0': break;
			case 'i', 'd': setarg(paramPos, 0, strval(string[stringPos]));
			case 'c': setarg(paramPos, 0, string[stringPos]);
			case 'f': setarg(paramPos, 0, _:floatstr(string[stringPos]));
			case 's':
			{
				new
					end = format[formatPos + 1] == '\0' ? '\0' : ' ',
					i;
				while (string[stringPos] != end) setarg(paramPos, i++, string[stringPos++]);
				setarg(paramPos, i, '\0');
			}
			default: goto skip;
		}
		while (string[stringPos] && string[stringPos] != ' ') stringPos++;
		while (string[stringPos] == ' ') stringPos++;
		paramPos++;
		skip:
		formatPos++;
	}
	return format[formatPos] ? 0 : 1;
}