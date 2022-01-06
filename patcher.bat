@ECHO OFF
SETLOCAL

rem Checks if resources are available.
if not exist prepack (
	echo Resources not found. Please extract all files.
	goto quit
)

rem Asks user for Titanfall 2 directory.
set tf2Dir=%~dp0
if not exist Titanfall2.exe (
	echo Please paste your Titanfall 2 directory.
	set /p tf2Dir=
	cd /d %tf2Dir%
	if not exist Titanfall2.exe (
		echo Titanfall 2 not found. Exiting...
		goto :quit
	)
)

if exist R2Northstar (
	set northstarExist=1
)
cls
goto menu

rem Creates a menu that leads to installing or uninstalling the language patch.
:menu
echo Titanfall 2 Directory: %tf2Dir%
echo:
echo DoroShiie's Language Patcher
echo =====================================
echo Choose from the following options:
echo 1. Install VPK files
echo 2. Uninstall VPK files
echo 3. Exit
set /p choice="> "

if %choice% == 1 (
	goto install
)

if %choice% == 2 (
	goto uninstall
)

if %choice% == 3 (
	goto quit
)
echo Invalid choice, please choose a valid option.
echo:
goto menu

rem Installs language patch. If the Northstar client is detected, it will patch Northstar to use English as well.
:install
cd /d %tf2Dir%
copy "%~dp0/prepack/vpk/englishclient_frontend.bsp.pak000_dir.vpk" "%tf2Dir%/vpk/englishclient_frontend.bsp.pak000_dir.vpk"
copy "%~dp0/prepack/vpk/client_frontend.bsp.pak000_228.vpk" "%tf2Dir%/client_frontend.bsp.pak000_228.vpk"
copy "%~dp0/prepack/vpk/englishclient_frontend.bsp.pak000_dir.vpk.backup" "%tf2Dir%/englishclient_frontend.bsp.pak000_dir.vpk.backup"
copy 
if %northstarExist% == 1 (
	cd "R2Northstar/mods/Northstar.Client/mod/resource"
	copy "northstar_client_localisation_japanese.txt" "northstar_client_localisation_japanese.txt.backup"
	copy "northstar_client_localisation_english.txt" "northstar_client_localisation_japanese.txt"
)
goto quit

rem Uninstalls language patch. If the Northstar client is detected, it will revert Northstar back to default.
:uninstall
cd /d %tf2Dir%
del "vpk/englishclient_frontend.bsp.pak000_dir.vpk"
del "vpk/client_frontend.bsp.pak000_228.vpk"
copy "vpk/englishclient_frontend.bsp.pak000_dir.vpk.backup" "vpk/englishclient_frontend.bsp.pak000_dir.vpk"
if %northstarExist = 1 (
	copy "northstar_client_localisation_japanese.txt.backup" "northstar_client_localisation_japanese.txt"
)
goto quit

:quit
pause