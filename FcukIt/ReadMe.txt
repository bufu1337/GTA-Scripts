/*
=======================
       FcukIt v3.0 Ultimate
        Coded by Scarface
=======================
*/

[url=http://www.ausamp.com/Scripts/FcukIt.rar]FcukIt v3.0 Ultimate[/url] 


For Questions / Suggestions
PM Me, or Email eazy_er_said_than_dunn@hotmail.com

I have thoroughly tested this script against all the features, however you must remember
that I am unable to pressure test the script with more than 6 players. People should keep this 
in mind when setting the actions of detection (Kick, Ban, Disarm). Set it to disarm/kick first to
ensure it is fully compatable with your server.

IMPORTANT:
I havn't included an amx version as it is important that you change the definition of MP in the top of the script. This
ensures maximum efficiency of FcukIt.
REMEMBER to also change this figure if your maximum server players changes.

*********************************

CONDITIONS OF USE:

The source is released for educational and server 
security purposes only. DO NOT copy or use 
any of the source code without conscent or rightful
credit to the author. Feel free to improve or modify 
the code, as long as full credit is given to myself and 
any other contributors. 

If you use FcukIt on your server DO NOT CHANGE the name
of the script, its functions or Credits.

**********************************

FEATURES:

FcukIt is the result of intense research, testing,
idea implementation, trial & error. I have spent countless
hours developing and testing this script and working on ideas
to bring an Anti-Cheat script to the SA-MP community that can 
help people who are either unable to code their own or just prefer to use FcukIt Anti-Cheat XD.

This Script Includes Anti-LaGG which is a Ping Kicker Script. 
It calculates players pings on a 5 loop average and supports
limits and tolerance where a player is warned twice before kicking
when they are within the "tolerance range".

Improvements/Features:
- User Configurable File 
- Most Detections Can be Individually Turned Off Live
- Restart and Emergency Shutdown Function
- Saves Kick/Ban Details [Player, Reason, Time, Date]
- Major Efficiency Improvements
- Full Implementation of DCMD
- Timer Overhaul
- IP Logging Tool

[color=red]Detection:
- Anti-Health Cheating (Detects v-0gelz)
- Anti-BannedWeapon Detection
- Anti-Cash Cheat Detection (Basic and FcukIt++ Include File)
- Anti-Spawn Killing
- Anti-DriveBy Abuse
- Anti-Prolong Inactivity (Pausers)
- Anti-Interior Kill
- Anti-Spoofing (Death Reason/ID Spoofing)
- Clone Detection[/color]



**********************************

[color=green]CONFIGURATION:

--------------------

A-Health 1          // 0 = Disabled, 1 = Kick, 2 = Ban
A-Cash 1            // 0 = Disabled, 1 = Kick, 2 = Ban
A-DriveBy 1        // 0 = Disabled, 1 = Kick, 2 = Ban, 3 = Disarm
A-Inactivity 1     // 0 = Disabled, 1 = Kick, 2 = Ban
A-BWeapons 1    // 0 = Disabled, 1 = Kick, 2 = Ban
A-OnKill         // 1 = Kick On Banned Weapon kill 2 = Ban on Banned Weapon Kill
A-InteriorKill 1     // 0 = Disabled, 1 = Kick, 2 = Ban
A-SpawnKill 1     // 0 = Disabled, 1 = Kick, 2 = Ban, 3 = Disarm
A-Spoofing 1     // 0 = Disabled, 1 = Kick, 2 = Ban
A-Cloning 1       // 0 = Disabled, 1 = Public Warning, 2 = Kick
A-Lagg 1          // 0 = Disabled, 1 = Enabled
Log-Enabled 0   // 0 = Disabled, 1 = Enabled (IP Log)
Max-Cash-Increase 1000000 // Maximum Cash Increase in cCheck Period
DB-Kills 3                          // Maximum Amount of Drive by Kills before Action
Inactive-Period 300            // Maximum Player Inactive Period (Seconds)
hCheck-Time 25                // Health-Loop Interval (Seconds)
cCheck-Time 5                 // Cash-Loop Interval (Seconds)
Spawn-Kill-Time 10           // Period After spawn that kill is considered "Spawn Killing"
Max-Spawn-kills 2            // Maximum Spawn Kills before Action
Ping-Limit 1500               // Ping Limit (Maximum Average Ping)
Ping-Intervals 5              // GetPing Intervals (Seconds)
Ping-Warning(0/1) 1        // 0 = Warning Disabled, 1 = Warning Enabled
Ping-Tolerance 20           // Amount below ping (ms) that players are warned (2 warnings then Kicked)

//Banned Weapon List: (-1 = Disabled)

Weapon2 36           // As it says, SA:MP Weapon ID's that you don't want to allow to own in the server.
Weapon3 35           // If you don't have 11 ID's just use -1 to disable that slot
Weapon4 38
Weapon5 39
Weapon6 40
Weapon7 -1
Weapon8 -1
Weapon9 -1
Weapon10 -1
Weapon11 -1
Weapon12 -1

[/color]

--------------------

[color=orange]COMMANDS(RCON ADMIN ONLY):
/fhealth, /fcash, /finactive, /fbweapons, /fskill, /fclone, /fdriveby - Disables/Enables (Toggle) respective function
/fhelp - Displays Commands List
/frestart - Restarts All Loops/Checks, Clears Variables
/fshutdown - Emergency Shutdown (Disables All Checks within FcukIt)
/fcukit - Shows Anti-Cheat Script Details/Version

[/color]

Instructions for Installation and use of FcukIt++

Installation:
To install this script simply ensure that ficonfig.txt is in your "scriptfiles" folder, the fcukit.amx is 
in the "FilterScripts" folder and you have added fcukit to the Filterscripts line in your server config.

Please NOTE: if you allow players with pings over 500, it is recommended to raise the loop times in the health detections (eg SetTimer("pauseresult", 1500, 0); instead of 1200ms. 

[color=red]FcukIt++:[/color]
FcukIt++ is an additional include that adds the feature of comparative cash checking. When including this in your gamemode, 
ensure you change ALL (VERY IMPORTANT) of your GivePlayerMoney()/ResetPlayerMoney() to FcukIt_GivePlayerMoney() and FcukIt_ResetPlayerMoney(). Add the line "#include <FcukIt++>" at the top of your script.

If you allow stunting in your server then it is recommended you change the stuntcash value in the include to a value that
you think is suitable as a maximum cash amount given for stunts within the cash check time. If not, simply disable them via the 
script native EnableStuntBonusForAll(0); or EnableStuntBonusForAll(false);

Developed by [DRuG]Scarface [Lethal Developments]

Check Out my DevBlog @ [url=http://sa-mp.tdsgames.com]http://sa-mp.tdsgames.com[/url]

Planned Features in FcukIt v3.1 Ultimate:
- Anti-Vehicle Health Hacking
- Increased effectiveness of Spoof Detection
- Bug Fixes (if any)

[color=red][b][u]DO YOU USE FcukIt?![/u][/b][/color]
If you use FcukIt on your server, pm or email me to be added to the affiliates list. Discuss improvements and I can give you direct support. Also become part of new features, code contribution and Beta Testing.

Official Affiliates:
** [Pure Evil] Australia