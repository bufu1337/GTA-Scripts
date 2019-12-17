@ECHO OFF
IF NOT EXIST %1 GOTO E_FOLDER

ECHO.
ECHO. Welcome to DracoBlue's Project Compiler
ECHO.
ECHO.       http://dracoblue.net
ECHO.
IF NOT EXIST %1\build mkdir %1\build
IF NOT EXIST %1\build\gamemodes mkdir %1\build\gamemodes
IF NOT EXIST %1\build\filterscripts mkdir %1\build\filterscripts
IF NOT EXIST %1\build\plugins mkdir %1\build\plugins
IF NOT EXIST %1\build\samp-server.exe copy ..\core\samp\samp-server.exe %1\build\samp-server.exe
IF NOT EXIST %1\build\announce.exe copy ..\core\samp\announce.exe %1\build\announce.exe
IF EXIST %1\build\gamemodes\%1.pwn del %1\build\gamemodes\%1.pwn
IF EXIST %1\build\gamemodes\%1.amx del %1\build\gamemodes\%1.amx
IF EXIST %1\compile.error.log del %1\compile.error.log
IF EXIST %1\compile.info.log del %1\compile.info.log
IF EXIST %1\build\server.cfg del %1\build\server.cfg
IF EXIST %1\build\server_log.txt del %1\build\server_log.txt
IF EXIST %1\docs.wiki.txt del %1\docs.wiki.txt
@cd ..\core\lua
lua.exe make_project.lua %1
@cd ..\..\projects
IF EXIST %1\build.error.log GOTO E_BUILDERRORS
..\core\pawn\pawncc "%1\build\gamemodes\%1.pwn" -o"%1\build\gamemodes\%1.amx" -r"%1\compile.info.log"  -e"%1\compile.error.log"  -O0 -; -(
IF EXIST "%1\build\gamemodes\%1.pwn" del "%1\build\gamemodes\%1.pwn"  
@cd ..\core\lua
lua.exe parse_errors.lua %1
@cd ..\..\projects
@cd ..\core\lua
lua.exe after_compile.lua %1
@cd ..\..\projects
IF EXIST %1\compile.info.log del %1\compile.info.log
IF EXIST %1\compile.error.log GOTO :EOF
IF EXIST %1\aftercompile.error.log GOTO E_AFTERCOMPILEERRORS
IF EXIST %1\build.error.log GOTO E_BUILDERRORS
ECHO.
ECHO. Successfully built %1! Run the server at %1\build\samp-server.exe now!
@GOTO EOF

:E_FOLDER
ECHO. 
ECHO. Error:
ECHO.   The project folder '%1' doesn't exist!
ECHO. 
@GOTO EOF
:E_AFTERCOMPILEERRORS
IF EXIST %1\aftercompile.error.log del %1\aftercompile.error.log
@GOTO EOF
:E_BUILDERRORS
IF EXIST %1\build.error.log del %1\build.error.log
@GOTO EOF

:EOF
IF EXIST %1\build.error.log del %1\build.error.log
IF EXIST %1\debug_output.log del %1\debug_output.log
@ECHO ON
