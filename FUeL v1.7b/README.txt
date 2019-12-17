//------------------------------------------------------------------------------
//
//   Fuel system + speedoMeter Filter Script v1.7b
//   NO MENUEs ONLY COMMANDS
//   CHECKPOINT HANDLER  Filter Script v1.0
//   Designed for SA-MP v0.2.2
//
//   Created by zeruel_angel translated into english and german by GTAIV
//   Now we have 18 gas station THANKS TO Donny and Fran0!
//   http://forum.sa-mp.com/index.php?topic=27691.0
//------------------------------------------------------------------------------

THis filter script was made for SA-MP 0.2.2
Don't be bad person, give me credits! zeruel_angel

If you have any problem, PM me (zeruel_angel) forum.sa-mp.com
http://forum.sa-mp.com/index.php?topic=27691.0
//------------------------------------------------------------------------------
                         To make it work 
//------------------------------------------------------------------------------
HOW TO USE FUELSYSTEM [FS]
1) Copy FuelS.pwn and FuelS.amx into FilterScripts folder
2) Copy FuelSystem.txt into your scriptfiles folder
3) Add FuelS and the end of the line that start with the word "FilterScripts" in 
   Server.cfg (open it with notepad)
4) Copy Check.pwn and Check.amx into FilterScripts folder
5) Copy CheckpointsFiles.txt into your scriptfiles folder
6) Add Check and the end of the line that start with the word "FilterScripts" in 
   Server.cfg (open it with notepad)

Enjoy!
http://forum.sa-mp.com/index.php?topic=27691.0
//------------------------------------------------------------------------------
                           To ADD MORE GAS STATION CHECKPOINTS
//------------------------------------------------------------------------------
Just add them in FuelSystem.txt
in the following way:
"SIZE X Y Z" (one per line)

//------------------------------------------------------------------------------
                           To ADD OTHER CHECKPOINTS FOR OTHER FS
//------------------------------------------------------------------------------
Just create a new TXT file, name it anyway, for example chekpoints1.txt. Inside 
that files paste all your coordinates in the following way
"SIZE X Y Z"
where 
     SIZE: is the size of the checkpoint.
     X: is the X coordenate.
     Y: is the Y coordenate.
     Z: is the Z coordenate.

Example: "1.0 2000.0 -1000.0 10.0" (One per line)

Finally just add the file name including the extension inside "CheckpointsFiles.txt" 
for example:
"chekpoints1.txt" (ONE per line.)

//------------------------------------------------------------------------------
//=============================== REMEMBER =====================================
//------------------------------------------------------------------------------
You can:

1) Use this filterscript on your server
2) Copy, modified, reverse enginier, use part, and play with the source code
3) Redistribute it

//------------------------------------------------------------------------------
You CAN'T

1) Claim you are the owner
2) Ask money for it
3) Pay for it
4) Erase me or other ppl from the credits

//------------------------------------------------------------------------------

PM me if you have any question "FORUM.SA-MP.COM" USER "zeruel_angel"