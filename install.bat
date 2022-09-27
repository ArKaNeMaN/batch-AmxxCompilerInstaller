@echo off

call config

:: TODO: Installation of deps like reapi etc

echo WARNING! This script will remove old destination folder.
echo Destination folder: %DESTINATION_PATH%
set /p warn="Press ENTER to continue..."

echo Download AmxModX base package...
call :rmdir %DOWNLOAD_PATH%
call :amxx-package-download %AMXMODX_BASE_PACKAGE% %DOWNLOAD_PATH%\%AMXMODX_BASE_PACKAGE%.zip

echo Unpack downloaded package...
call :rmdir %PACKAGE_PATH%
call :unzip %DOWNLOAD_PATH%\%AMXMODX_BASE_PACKAGE%.zip %PACKAGE_PATH%

echo Cleanup scripting folder...
for /R %SCRIPTING_PATH% %%F in (*.sma) do (
    del %%F
)
call :rmdir %SCRIPTING_PATH%\testsuite
call :del %SCRIPTING_PATH%\compile.exe

echo Rename compiler executable...
ren %SCRIPTING_PATH%\amxxpc.exe %AMXMODX_COMPILER_EXECUTABLE%.exe

echo Move compiler to destination foler...
call :rmdir %DESTINATION_PATH%
call :copy %SCRIPTING_PATH% %DESTINATION_PATH%

echo Cleanup temp files...
call :rmdir %PACKAGE_PATH%
call :rmdir %DOWNLOAD_PATH%

echo Update env vars...
setx AMXX_COMPILER_EXECUTABLE "%AMXMODX_COMPILER_EXECUTABLE%">nul
setx AMXX_COMPILER_DIR "%DESTINATION_PATH%">nul
setx AMXX_COMPILER_VERSION "%AMXMODX_COMPILER_VERSION%">nul

echo Installation finished.

exit 0

:amxx-package-download
	call :mkdir %DOWNLOAD_PATH%

    SET AMXMODX_LATEST_BUILD_NAME=amxmodx-%AMXMODX_VERSION%.0-git%AMXMODX_BUILD%-%~1-windows.zip
	if "%AMXMODX_BUILD%" == "" (
       call :download "https://www.amxmodx.org/amxxdrop/%AMXMODX_VERSION%/amxmodx-latest-%~1-windows" %DOWNLOAD_PATH%\%~1-latest.txt
	   (Set /P "AMXMODX_LATEST_BUILD_NAME=") 0< "%DOWNLOAD_PATH%\%~1-latest.txt"
	)
	
    call :download "https://www.amxmodx.org/amxxdrop/%AMXMODX_VERSION%/%AMXMODX_LATEST_BUILD_NAME%" %~2
exit /b

:download
    powershell -Command "Invoke-WebRequest %~1 -OutFile %~2"
exit /b

:unzip
    powershell -Command "Expand-Archive %~1 -DestinationPath %~2"
exit /b

:mkdir
    if not exist %~1 mkdir %~1
exit /b

:rmdir
    if exist %~1 rd /S /q %~1
exit /b

:copy
    powershell Copy-Item -Path %~1 -Destination %~2 -Recurse -Force
exit /b

:del
    if exist %~1 del %~1
exit /b

:add-path
    path|find /i "%~1" >nul || set path=%path%;%~1
exit /b
