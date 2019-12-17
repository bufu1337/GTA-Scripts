#include <a_samp>
#include "../Includes/audio.inc"
#define MAX_RADIOS 100
#define DIALOG_RADIO 2432
#define SLOTS 20

new RadioCriadas=-1;
enum RadioInfo
{
    NomeRadio[64],
    URLRadio[128],
    RadioID
};

new RadioAdd[MAX_RADIOS][RadioInfo];
public OnFilterScriptInit()
{
    AddRadio("Radio Fusion","http://radiofusion.com.br/aovivo.asx");

    Audio_SetPack("default_pack", true);
    return true;
}
stock AddRadio(nomer[],url[])
{
    RadioCriadas++;
    format(RadioAdd[RadioCriadas][NomeRadio],64,"%s",nomer);
    format(RadioAdd[RadioCriadas][URLRadio],64,"%s",url);
    RadioAdd[RadioCriadas][RadioID] = RadioCriadas;
    printf("Radio %s Adicionada com Sucesso (id:%d)",nomer,RadioCriadas);
    return ;
}
public Audio_OnClientConnect(playerid)
{
	Audio_TransferPack(playerid);
}

public Audio_OnSetPack(audiopack[])
{
	for (new i = 0; i < SLOTS; i++)
		Audio_TransferPack(i);
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_RADIO)
	{
    	new item = listitem;
    	if(item == RadioAdd[item][RadioID])
    	{
        	if(!response)
			{
				Audio_Stop(playerid, GetPVarInt(playerid, "Radios"));
				return SendClientMessage(playerid, 0xFFFFFFFF, "Você parou a rádio");
			}
			if(response)
			{
				printf("Radio %d",item);
        		SetPVarInt(playerid, "Radios", Audio_PlayStreamed(playerid,RadioAdd[item][URLRadio]));
        		return true;
        	}
    	}
    }
    return 0;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
    new strmem[1024];
    if(!strcmp(cmdtext, "/radios", true))
    {
        format(strmem, 1024, "");
        for(new mem=0;mem<=RadioCriadas;mem++)
        {
            format(strmem,1024, "%s%s\n",strmem,RadioAdd[mem][NomeRadio]);
        }
        ShowPlayerDialog(playerid,DIALOG_RADIO,DIALOG_STYLE_LIST, "Lista de para Ouvir:",strmem,"Ouvir", "Parar");
    }
    return 0;
}

