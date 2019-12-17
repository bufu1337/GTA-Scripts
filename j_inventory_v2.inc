#define INV_DIALOG_ID 13337
#define MAX_ITEMS 20
#define MAX_ITEM_STACK 99
#define MAX_ITEM_NAME 24
forward OnPlayerUseItem(playerid,ItemName[]);
new gItemList[(MAX_ITEMS+1)*(MAX_ITEM_NAME+3)];
/*
native AddItem(playerid,ItemName[],Amount);
native RemoveItem(playerid,ItemName[],Amount);
native PlayerHasItem(playerid,ItemName[]);
native GetPlayerItemInfo(playerid,&idx,const ItemName[],len=sizeof(ItemName),&Amount);
native ResetPlayerInventory(playerid);
native ShowInventory(playerid);
native InventoryOnDialogResponse(playerid, dialogid, response, inputtext[]);
native SaveInventory(playerid);
native LoadInventory(playerid);
*/
stock _GetItemNamePVar(playerid,item)
{
	new tmp[32];
	new tmp2[MAX_ITEM_NAME];
	format(tmp,32,"PITEMNAME%d",item);
	GetPVarString(playerid,tmp,tmp2,MAX_ITEM_NAME);
	return tmp2;
}
stock _SetItemNamePVar(playerid,item,ItemName[])
{
	new tmp[MAX_ITEM_NAME];
	format(tmp,MAX_ITEM_NAME,"PITEMNAME%d",item);
	SetPVarString(playerid,tmp,ItemName);
}
stock _GetItemAmountPVar(playerid,item)
{
	new tmp[16];
	format(tmp,16,"PITEMAMOUNT%d",item);
	return GetPVarInt(playerid,tmp);
}
stock _SetItemAmountPVar(playerid,item,Amount)
{
	new tmp[16];
	format(tmp,16,"PITEMAMOUNT%d",item);
	SetPVarInt(playerid,tmp,Amount);
}
stock AddItem(playerid,ItemName[],Amount)
{
	new slot=-1;
	for(new item;item<MAX_ITEMS;item++)
	{
		if(!_GetItemAmountPVar(playerid,item))
		{
			if(slot==-1)slot=item;
			continue;
		}
		if(!strcmp(_GetItemNamePVar(playerid,item),ItemName,true))
		{
			_SetItemAmountPVar(playerid,item,_GetItemAmountPVar(playerid,item)+Amount);
			if(_GetItemAmountPVar(playerid,item)<=0)_SetItemAmountPVar(playerid,item,0);
			if(_GetItemAmountPVar(playerid,item)>MAX_ITEM_STACK)
			{
				_SetItemAmountPVar(playerid,item,MAX_ITEM_STACK);
				return 2;
			}
			return 1;
		}
	}
	if(slot>-1)
	{
		_SetItemNamePVar(playerid,slot,ItemName);
		_SetItemAmountPVar(playerid,slot,Amount);
		if(_GetItemAmountPVar(playerid,slot)>MAX_ITEM_STACK)
		{
			_SetItemAmountPVar(playerid,slot,MAX_ITEM_STACK);
			return 2;
		}
		return 1;
	}
	return 0;
}
stock RemoveItem(playerid,ItemName[],Amount)
{
	for(new item;item<MAX_ITEMS;item++)
	{
		if(!_GetItemAmountPVar(playerid,item))continue;
		if(!strcmp(_GetItemNamePVar(playerid,item),ItemName,true))
		{
			_SetItemAmountPVar(playerid,item,_GetItemAmountPVar(playerid,item)-Amount);
			if(_GetItemAmountPVar(playerid,item)<=0)_SetItemAmountPVar(playerid,item,0);
			if(_GetItemAmountPVar(playerid,item)>MAX_ITEM_STACK)
			{
				_SetItemAmountPVar(playerid,item,MAX_ITEM_STACK);
				return 2;
			}
			return 1;
		}
	}
	return 0;
}
stock PlayerHasItem(playerid,ItemName[])
{
	for(new item;item<MAX_ITEMS;item++)
	{
		if(!_GetItemAmountPVar(playerid,item))continue;
		if(!strcmp(_GetItemNamePVar(playerid,item),ItemName,false))return _GetItemAmountPVar(playerid,item);
	}
	return 0;
}
stock GetPlayerItemInfo(playerid,&idx,ItemName[],len=sizeof(ItemName),&Amount)
{
	if(idx>=MAX_ITEMS)return 0;
	format(ItemName,len,_GetItemNamePVar(playerid,idx));
	Amount=_GetItemAmountPVar(playerid,idx);
	idx++;
	return 1;
}
stock ResetPlayerInventory(playerid)
{
	for(new item;item<MAX_ITEMS;item++)_SetItemAmountPVar(playerid,item,0);
}
stock ShowInventory(playerid)
{
	gItemList="";
	for(new item;item<MAX_ITEMS;item++)
	{
		if(!strlen(_GetItemNamePVar(playerid,item))||!_GetItemAmountPVar(playerid,item))continue;
		format(gItemList,sizeof(gItemList),"%s\n%d\t\t%s",gItemList,_GetItemAmountPVar(playerid,item),_GetItemNamePVar(playerid,item));
	}
	format(gItemList,sizeof(gItemList),"Amount\t\tItem Name%s",gItemList);
	ShowPlayerDialog(playerid,INV_DIALOG_ID,DIALOG_STYLE_LIST,"Inventory",gItemList,"Use","Close");
	SetPVarInt(playerid,"PUSINGDIALOG",1);
}
stock SaveInventory(playerid)
{
	gItemList="";
	new filename[48];
	GetPlayerName(playerid,filename,24);
	format(filename,48,"Inventory/%s.inv",filename);
	new File:file=fopen(filename,io_write);
	for(new item;item<MAX_ITEMS;item++)
	{
		if(!strlen(_GetItemNamePVar(playerid,item))||!_GetItemAmountPVar(playerid,item))continue;
		format(gItemList,sizeof(gItemList),"%s%s\n%d\n",gItemList,_GetItemNamePVar(playerid,item),_GetItemAmountPVar(playerid,item));
	}
	fwrite(file,gItemList);
	fclose(file);
	GetPlayerName(playerid,filename,24);
	printf("[INV] %s[%d]'s inventory saved.",filename,playerid);
}
stock LoadInventory(playerid)
{
	new tstring[48];
	new tstring2[12];
	GetPlayerName(playerid,tstring,48);
	format(tstring,48,"Inventory/%s.inv",tstring);
	if(!fexist(tstring))return 0;
	new File:file=fopen(tstring,io_read);
	fread(file,tstring);
	while(tstring[0])
	{
		format(tstring,strlen(tstring),"%s",tstring); //Delete last character
		fread(file,tstring2);
		AddItem(playerid,tstring,strval(tstring2));
		fread(file,tstring);
	}
	fclose(file);
	GetPlayerName(playerid,tstring,24);
	printf("[INV] %s[%d]'s inventory loaded.",tstring,playerid);
	return 1;
}
InventoryOnDialogResponse(playerid, dialogid, response, inputtext[])
{
	if(dialogid!=INV_DIALOG_ID)return 1;
	if(!GetPVarInt(playerid,"PUSINGDIALOG"))return 1;
	if(!response)return 1;
	if(!strcmp(inputtext,"Amount",true,6))
	{
		ShowInventory(playerid);
		return 1;
	}
	format(gItemList,MAX_ITEM_NAME,inputtext[strfind(inputtext,"\t")+2]);
	if(CallLocalFunction("OnPlayerUseItem","is",playerid,gItemList))ShowInventory(playerid);
	else SetPVarInt(playerid,"PUSINGDIALOG",0);
	return 1;
}