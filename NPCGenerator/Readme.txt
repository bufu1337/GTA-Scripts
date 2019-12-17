Thank you for downloading the NPC Generator. In this little txt, i will show you how to instal & use it.Follow the steps:


Instaling The NPC Generator:

1) Download the NPC Generator.
2) Place the 2 files in your filterscripts folder.
3) Open server.cfg ( with notepad ) and add the NPCGenerator at ' filterscripts '.
4) Close The server.cfg.
5) Run the Server.


How to use The NPC Generator:

1) Go In Game and Login As Rcon ( /rcon login password ).
2) Type /createnpc.
3) Follow The Steps ( Skin Selecting, Weapon Selecting...).
4) After you finish, close the game, enter your scriptfiles folder and you will see your file + NPC.pwn file.
5) Place The NPC.pwn file in npcmodes folder ( you may edit the file if you want ), and the recorded file in the npcmodes/recordings.
6) Connect your NPC to the server. ( ConnectNPC(name[],file[]);
7) Ok now go in your gamemode / filterscript at OnPlayerSpawn, then do:

if(IsPlayerNPC(playerid))
{
	SetPlayerSkin(playerid,skinid*);
	GivePlayerWeapon(playerid,weaponid**,99999);
        return 1;
}

skinid* = The skin id that you inserted while you were making the NPC.
weaponid** = The weapon id that you inserted while you were making the NPC.

Copyright © Balkan Role-Play Team. All Rights Reserved.