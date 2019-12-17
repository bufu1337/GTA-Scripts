//------------------------------------------------------------------------------------------------------
//    ===== SUSTENTO LOGICO PARA MANTENCION DE MULTIPLES CHECKPOINTS ======
//                              ZERUEL_ANGEL
//              http://forum.sa-mp.com/index.php?topic=27691.0
//------------------------------------------------------------------------------------------------------

#include <a_samp>

forward LIBLOOPINGCHECK();

//Distancia maxima a la que se deben ver los checkpoints
#define MAXDISTANCECHECK 150.0
#define MAXCHECKP 100
#define CANT_ARCH 1
//Vector con los nombres de los archivos con los checkpoints
new archName[25];
new ArchNames[]={"CheckpointsFiles.txt"};
new CantidadCheckp;
new Float:checkAnt[MAX_PLAYERS][4];
new Float:checkPNORM[MAXCHECKP][4];

public OnFilterScriptInit()
	{
	print("\n CheckPointH Filter Script v1.0 Laden...\n*****************************\n      (Zeruel_Angel)\n");
	//Cargo los CHECKPOINTS DE LOS ARCHIVOS
	new linea[255];
	new File:file;
	new File:file1;
 	new i=0;
 	new j=0;
 	new idx;
 	while ((i<CANT_ARCH)&&(j<MAXCHECKP))
	    {
     	format(archName, sizeof(archName), ArchNames);
        if 	(fexist(archName))
            {
			file = fopen(archName,io_readwrite);
	    	while	(fread(file,linea,sizeof(linea),false))
					{
					if (fexist(linea))
					    {
				  		file1 = fopen(linea,io_readwrite);
				     	while	(fread(file1,linea,sizeof(linea),false))
								{
						  		idx = 0;
								checkPNORM[j][0] = floatstr(strtok(linea,idx));
								checkPNORM[j][1] = floatstr(strtok(linea,idx));
								checkPNORM[j][2] = floatstr(strtok(linea,idx));
								checkPNORM[j][3] = floatstr(strtok(linea,idx));
								j++;
								}
		                fclose(file1);
		                }
					}
			}
		i++;
	    }
    fclose(file);
	CantidadCheckp=j;
	format(linea,sizeof(linea),"Aantal checkpoints geladen: %d", j);
	print(linea);
	//inicio el sistema automatico
	SetTimer("LIBLOOPINGCHECK",1500,1);
	}

//-----------------------------------------------------------------------------------------------------
public OnFilterScriptExit()
	{
    print("\n**********************\n CheckPointH System Filter Script UnLoaded*\n**********************\n");
	return 1;
	}
//-----------------------------------------------------------------------------------------------------
  Float:GetDistanceToPoint(playerid,Float:x2,Float:y2,Float:z2)
		{
		if (IsPlayerConnected(playerid))
			{
			new Float:x1,Float:y1,Float:z1;
			GetPlayerPos(playerid,x1,y1,z1);
			return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
			}
		return -1.0;
		}

//-----------------------------------------------------------------------------------------------------
  DisablePlayerCheckpoint2(playerid)
	{
	DisablePlayerCheckpoint(playerid);
	checkAnt[playerid][1]= -999.9;
	checkAnt[playerid][2]= -999.9;
	return 1;
	}
//-----------------------------------------------------------------------------------------------------
public LIBLOOPINGCHECK()
		{
		new player;
		for (player=0;player<MAX_PLAYERS;player++)
		    {
    		new Float:distNew = 0.0;
			new Float:distOld = 999999.0;
			new cercano = 0;
    		new index=0;
			for (index=0;index<CantidadCheckp;index++)
				{
				distNew = GetDistanceToPoint(player,checkPNORM[index][1],checkPNORM[index][2],checkPNORM[index][3]);
				if 	(distNew<distOld)
					{
					distOld=distNew;
					cercano=index;
					}
  				}
			if 	(distOld < MAXDISTANCECHECK)//chequeamos si esta cerca como para dibujarlo.
	    		{
			    if 	((checkPNORM[cercano][1]!=checkAnt[player][1])&&(checkPNORM[cercano][2]!=checkAnt[player][2]))//chequeo si no es el anteriormente dibujado
			        {
			        DisablePlayerCheckpoint2(player);
			        SetPlayerCheckpoint(player,checkPNORM[cercano][1],checkPNORM[cercano][2],checkPNORM[cercano][3],checkPNORM[cercano][0]);
 					checkAnt[player][1]=checkPNORM[cercano][1];
 					checkAnt[player][2]=checkPNORM[cercano][2];
			        }
			    }
			else
				{
				DisablePlayerCheckpoint2(player);
		        }
			}
		}

//------------------------------------------------------------------------------------------------------
 strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
