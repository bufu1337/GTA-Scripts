//------------------------------------------------------------------------------
//
//   Fuel system + speedoMeter Filter Script v1.7
//   CHECKPOINT HANDLER  Filter Script v1.0
//   Gemaakt voor SA-MP v0.2.2
//
//   Gemaakt door zeruel_angel           vertaald naar het nederlands door GtaMaster
//   (Translated to dutch by GtaMaster   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^)
//   Nu hebben we 18 benzinepompen. Speciaal bedankje naar Donny en Fran0!
//   http://forum.sa-mp.com/index.php?topic=27691.0
//------------------------------------------------------------------------------

Dit filterscript is gemaakt voor SA-MP 0.2.2
Wees geen slecht persoon, en geef credits aan zeruel_angel

Als je een probleem hebt, stuur een PM naar (zeruel_angel) forum.sa-mp.com
http://forum.sa-mp.com/index.php?topic=27691.0
//------------------------------------------------------------------------------
                         Om het te laten werken 
//------------------------------------------------------------------------------
Hoe de FULLSYSTEM [FS] te gebruiken
1) Kopiëer FuelS.pwn, FuelS.amx, Check.pwn en Check.amx naar je FilterScripts map
2) Kopiëer FuelSystem.txt,CheckpointsFiles.txt en FuelConf.txt naar je scriptfiles map
3) Voeg FuelS en Check  het eind van de lijn wat begint met het woord "FilterScripts" in 
   Server.cfg toe (open het met kladblok)

6) Voeg Check en het einde van de lijn wat begint met "FilterScripts" in 
   Server.cfg toe (open het met kladblok)
1) Copy  into FilterScripts folder
2) Copy  into your scriptfiles folder
3) Add FuelS and Check  the end of the line that start with the word "FilterScripts" in 
   Server.cfg (open it with notepad)
4) Edit FuelConf.txt to your desire, "1" mean YES, "0" mean NO
5) If you deside NOT TO USE THE CHECKPOINT HANDLER, erase the word "check" from server.cfg
   NOTICE THAT FuelMenues only work with checkpoints.

Veel plezier, en succes!
http://forum.sa-mp.com/index.php?topic=27691.0
//------------------------------------------------------------------------------
                           Hoe meer tankstations toe te voegen
//------------------------------------------------------------------------------
Zet ze gewoon in FuelSystem.txt
op de volgende manier:
"SIZE X Y Z" (one per line)

//-----------------------------------------------------------------------------
           Meer checkpoints voor de nieuwe tankstations neer te zetten
//-----------------------------------------------------------------------------
Maak gewoon een nieuw TXT bestand, maakt niet uit welke naam, maar als voorbeeld chekpoints1.txt
In dat bestand zet je alle coördinaten zoals in het volgende voorbeeld:
"SIZE X Y Z"
where 
     SIZE: is de grootte van de checkpoint.
     X: is the X coordenate.
     Y: is the Y coordenate.
     Z: is the Z coordenate.

Voorbeeld: "1.0 2000.0 -1000.0 10.0" (EEN per regel)

Als laatst kun je de bestandsnaam inclusief de extensie bijvoegen in "CheckpointsFiles.txt" 
Als voorbeeld:
"chekpoints1.txt" (EEN per regel.)

//------------------------------------------------------------------------------
//=============================== ONTHOUD ======================================
//------------------------------------------------------------------------------
Je kunt:

1) Dit filterscript op je server gebruiken
2) Kopiëeren, veranderen en delen gebruiken van het standaard script
3) Alles netjes verdelen

//------------------------------------------------------------------------------
JE KAN NIET:

1) Zeggen dat jij dit gemaakt hebt
2) Er geld voor vragen
3) Ervoor betalen
4) Mij of andere mensen verwijderen van de credits

//------------------------------------------------------------------------------

Als je een vraag hebt, stuur een PM naar (zeruel_angel) forum.sa-mp.com