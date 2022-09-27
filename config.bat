@echo off

:: 1.9 / 1.10
set AMXMODX_VERSION=1.9
:: amxx190 / amxx1100
set AMXMODX_COMPILER_EXECUTABLE=amxx190
:: 1.9.0 / 1.10.0
set AMXMODX_COMPILER_VERSION=1.9.0
:: Build index (Ex. 5294). Empty = latest
set AMXMODX_BUILD=

:: Don't change
set ROOT_PATH=%CD%
set DOWNLOAD_PATH=%ROOT_PATH%\.dl
set PACKAGE_PATH=%ROOT_PATH%\.package
set SCRIPTING_PATH=%PACKAGE_PATH%\addons\amxmodx\scripting
set AMXMODX_BASE_PACKAGE=base
rem set DESTINATION_PATH=%ROOT_PATH%\.destination-test
set DESTINATION_PATH=%USERPROFILE%\AmxModX\%AMXMODX_COMPILER_VERSION%
