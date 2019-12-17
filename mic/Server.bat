@echo off
md Gamemodes.bak
set path=Gamemodes.bak
set rand=%RANDOM%
:Log
echo ==[ MiC Debug Handler]==
echo [HANDLER]: Current Date: %DATE%
echo [HANDLER]: Current Time: %TIME%
echo [HANDLER]: Current Hash: %rand%
copy gamemodes\*.pwn %path%\*.%rand%.pwn
echo [HANDLER]: Files Were Saved Successfully.
echo [HANDLER]: Launching Server.
:restart
samp-server.exe
echo [HANDLER]: Server Crashed.
pause
echo [HANDLER]: Server Restarting.
goto restart