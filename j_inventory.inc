#define INV_DIALOG_ID 13337
#define MAX_ITEMS 20
#define MAX_ITEM_NAME 24
forward OnPlayerUseItem(playerid,ItemName[]);
new pUsingDialog[MAX_PLAYERS];
new pItemNames[MAX_PLAYERS][MAX_ITEMS][MAX_ITEM_NAME];
new pItemAmounts[MAX_PLAYERS][MAX_ITEMS];
new gItemList[(MAX_ITEMS+1)*(MAX_ITEM_NAME+3)];
/*
native AddItem(playerid,ItemName[],Amount);
native RemoveItem(playerid,ItemName[],Amount);
native PlayerHasItem(playerid,ItemName[]);
native GetPlayerItemInfo(playerid,&idx,const ItemName[],len=sizeof(ItemName),&Amount);
native ResetPlayerInventory(playerid);
native ShowInventory(playerid);
native InventoryOnDialogResponse(playerid, dialogid, response, inputtext[]);
*/
stock AddItem(playerid,ItemName[],Amount)
{
	new slot=-1;
	for(new item;item<MAX_ITEMS;item++)
	{
		if(!strlen(pItemNames[playerid][item])&&(slot==-1))slot=item;
		if(!strlen(pItemNames[playerid][item]))continue;
		if(!strcmp(pItemNames[playerid][item],ItemName,true))
		{
			pItemAmounts[playerid][item]+=Amount;
			if(pItemAmounts[playerid][item]<=0)
			{
				pItemAmounts[playerid][item]=0;
				format(pItemNames[playerid][item],MAX_ITEM_NAME,"");
			}
			return 1;
		}
	}
	if(slot>-1)
	{
		format(pItemNames[playerid][slot],MAX_ITEM_NAME,ItemName);
		pItemAmounts[playerid][slot]=Amount;
		return 1;
	}
	return 0;
}
stock RemoveItem(playerid,ItemName[],Amount)
{
	for(new item;item<MAX_ITEMS;item++)
	{
		if(!strlen(pItemNames[playerid][item]))continue;
		if(!strcmp(pItemNames[playerid][item],ItemName,true))
		{
			pItemAmounts[playerid][item]-=Amount;
			if(pItemAmounts[playerid][item]<=0)
			{
				pItemAmounts[playerid][item]=0;
				format(pItemNames[playerid][item],MAX_ITEM_NAME,"");
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
		if(!strlen(pItemNames[playerid][item])continue;
		if(!strcmp(pItemNames[playerid][item],ItemName,false))return pItemAmounts[playerid][item];
	}
	return 0;
}
stock GetPlayerItemInfo(playerid,&idx,ItemName[],len=sizeof(ItemName),&Amount)
{
	if(idx>MAX_ITEMS)return 0;
	format(ItemName,len,pItemNames[playerid][idx]);
	Amount=pItemAmounts[playerid][idx];
	idx++;
	return 1;
}
stock ResetPlayerInventory(playerid)
{
	for(new item;item<MAX_ITEMS;item++)
	{
		format(pItemNames[playerid][item],MAX_ITEM_NAME,"");
		pItemAmounts[playerid][item]=0;
	}
}
stock ShowInventory(playerid)
{
	gItemList="";
	for(new item;item<MAX_ITEMS;item++)
	{
		if(pItemAmounts[playerid][item]<=0)
		{
			pItemAmounts[playerid][item]=0;
			format(pItemNames[playerid][item],MAX_ITEM_NAME,"");
		}
		if(!strlen(pItemNames[playerid][item]))continue;
		format(gItemList,sizeof(gItemList),"%s\n%d\t\t%s",gItemList,pItemAmounts[playerid][item],pItemNames[playerid][item]);
	}
	format(gItemList,sizeof(gItemList),"Amount\t\tItem Name%s",gItemList);
	ShowPlayerDialog(playerid,INV_DIALOG_ID,DIALOG_STYLE_LIST,"Inventory",gItemList,"Use","Close");
	pUsingDialog[playerid]=1;
}
InventoryOnDialogResponse(playerid, dialogid, response, inputtext[])
{
	if(dialogid!=INV_DIALOG_ID)return 1;
	if(!pUsingDialog[playerid])return 1;
	if(!response)return 1;
	if(!strcmp(inputtext,"Amount",true,6))
	{
		ShowInventory(playerid);
		return 1;
	}
	format(gItemList,MAX_ITEM_NAME,inputtext[strfind(inputtext,"\t")+2]);
	if(CallLocalFunction("OnPlayerUseItem","is",playerid,gItemList))ShowInventory(playerid);
	else pUsingDialog[playerid]=0;
	return 1;
}