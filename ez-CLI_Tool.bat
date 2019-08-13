@call :GET_CURRENT_DIR
@cd %THIS_DIR%
@ECHO OFF
rem *************************************************************
rem ***                                                       ***
rem ***          Begin: parameters specific to users          ***
rem ***                                                       ***
rem ***  T-ADDRESS is your Public VRSC Address                ***
rem ***  Z-ADDRESS is your Private VRSC Address               ***
rem ***                                                       ***
rem ***  FILELOCATION is your complete path to the verus      ***
rem ***  binaries. e.g. C:\mining\verus-cli                   ***
rem ***                                                       ***
rem *************************************************************
set T-ADDRESS=REPLACE_WITH_YOUR_TRANSPARENT_R-ADDRESS
set Z-ADDRESS=REPLACE_WITH_YOUR_PRIVATE_Z-ADDRESS
set FILELOCATION=REPLACE_WITH_FULL_PATH_TO_YOUR_CLI_EXECUTABLES
rem *************************************************************
rem ***           End: parameters specific to users           ***
rem *************************************************************

CLS
:MENU
CLS
ECHO.
ECHO                 ez-CLI Verus toolbox
ECHO        Special thanks and credit to Ginasis Mining
ECHO              for creating the staking tool
ECHO       alterations and additions by Oink and G.Ballz
ECHO.
ECHO .....................................................
ECHO PRESS 1, 2, 3, ss OR sv to select your task, or ex to EXIT.
ECHO .....................................................
ECHO.
ECHO 1  - Start Verus with staking
ECHO 2  - Start Staking
ECHO 3  - Check Staking Status
ECHO 4  - Check Balance
ECHO 5  - Get Wallet Info
ECHO 6  - List Address Groupings
ECHO 0  - List Z-Addresses
ECHO z  - Get Z Balance
ECHO s  - Shield All Recent Coinbase Transactions to Z-Address
ECHO r  - Transfer all funds from Z to R
ECHO o  - Get Operation Status
ECHO n  - Get Network Info
ECHO b  - Get Blockchain Info
ECHO d  - Get Network Difficulty
ECHO u  - List Unspent
ECHO h  - Help (Lists Commands)
ECHO ss - Stop Staking
ECHO sv - Stop Verus
ECHO ex - EXIT
ECHO.
color 30
SET /P M=Type 1, 2, 3, 4, 5, 6 or 7 then press ENTER:
IF %M%==1 GOTO STARTVERUS
IF %M%==sv GOTO STOPVERUS
IF %M%==2 GOTO STARTSTAKING
IF %M%==ss GOTO STOPSTAKING
IF %M%==3 GOTO STAKINGSTATUS
IF %M%==4 GOTO BALANCE
IF %M%==ex GOTO eof
IF %M%==6 GOTO LISTADDRESSGROUPINGS
IF %M%==5 GOTO GETWALLETINFO
IF %M%==s GOTO Z_SHIELDCOINBASE
IF %M%==z GOTO Z_GETBALANCE
IF %M%==r GOTO Z_MERGETOADDRESS
IF %M%==o GOTO Z_GETOPERATIONSTATUS
IF %M%==0 GOTO Z_LISTADDRESSES
IF %M%==u GOTO LISTUNSPENT
IF %M%==n GOTO GETNETWORKINFO
IF %M%==b GOTO GETBLOCKCHAININFO
IF %M%==d GOTO GETDIFFICULTY
IF %M%==h GOTO HELP

:STARTVERUS
@call :GET_CURRENT_DIR
@cd %AppData%/Komodo/VRSC
CLS
start %FILELOCATION%\verusd -mint
@cd %THIS_DIR%
ECHO.
ECHO Verus started
TIMEOUT /T 5
GOTO MENU

:STOPVERUS
@call :GET_CURRENT_DIR
@cd %THIS_DIR%
CLS
%FILELOCATION%/verus stop
ECHO.
ECHO Verus stopped
TIMEOUT /T 5
GOTO MENU


:STARTSTAKING
@call :GET_CURRENT_DIR
@cd %THIS_DIR%
CLS
%FILELOCATION%/verus setgenerate true
ECHO.
ECHO Staking succsesfully switched on
TIMEOUT /T 5
GOTO MENU

:STOPSTAKING
@call :GET_CURRENT_DIR
@cd %THIS_DIR%
CLS
rem cd %FILELOCATION%
%FILELOCATION%/verus setgenerate false
ECHO.
ECHO Staking succsesfully switched off
TIMEOUT /T 5
GOTO MENU

:STAKINGSTATUS
@call :GET_CURRENT_DIR
@cd %THIS_DIR%
CLS
%FILELOCATION%/verus getmininginfo
ECHO.
TIMEOUT /T 10
GOTO MENU

:BALANCE
@call :GET_CURRENT_DIR
@cd %THIS_DIR%
CLS
%FILELOCATION%/verus getbalance
ECHO.
TIMEOUT /T 10
GOTO MENU

:LISTADDRESSGROUPINGS
@cd %THIS_DIR%
%FILELOCATION%/verus listaddressgroupings
ECHO.
TIMEOUT /T 15
GOTO MENU

:GETWALLETINFO
@cd %THIS_DIR%
%FILELOCATION%/verus getwalletinfo
ECHO.
TIMEOUT /T 10
GOTO MENU

:Z_GETBALANCE
@cd %THIS_DIR%
%FILELOCATION%/verus z_getbalance "%Z-ADDRESS%"
ECHO.
TIMEOUT /T 10
GOTO MENU

:Z_SHIELDCOINBASE
@cd %THIS_DIR%
@echo on
%FILELOCATION%/verus z_shieldcoinbase "*" "%Z-ADDRESS%"
ECHO.
TIMEOUT /T 10
@echo off
GOTO MENU

:Z_MERGETOADDRESS
@cd %THIS_DIR%
@SETLOCAL EnableDelayedExpansion

REM Command below disabled for off-line testing
For /F "delims=" %%I in ('%FILELOCATION%/verus z_getbalance "%Z-ADDRESS%"') Do Set BALANCE=%%I
REM command below inserted for testing
REM set BALANCE=23.99990000

call :strLen BALANCE LENGTH
set SATOSHI=%BALANCE:.=%
SET /a i=%LENGTH%
:loop
if %i% equ 17 goto :endfor
set SATOSHI=0%SATOSHI%
set /a "i+=1"
goto :loop
:endfor
set /a SAT16=%SATOSHI:~15,1%
set /a SAT15=%SATOSHI:~14,1%
set /a SAT14=%SATOSHI:~13,1%
set /a SAT13=%SATOSHI:~12,1%
set /a S4=%SAT16%+(10*%SAT15%)+(100*%SAT14%)+(1000*%SAT13%)
set /a SAT12=%SATOSHI:~11,1%
set /a SAT11=%SATOSHI:~10,1%
set /a SAT10=%SATOSHI:~9,1%
set /a SAT09=%SATOSHI:~8,1%
set /a S3=%SAT12%+(10*%SAT11%)+(100*%SAT10%)+(1000*%SAT09%)
set /a SAT08=%SATOSHI:~7,1%
set /a SAT07=%SATOSHI:~6,1%
set /a SAT06=%SATOSHI:~5,1%
set /a SAT05=%SATOSHI:~4,1%
set /a S2=%SAT08%+(10*%SAT07%)+(100*%SAT06%)+(1000*%SAT05%)
set /a SAT04=%SATOSHI:~3,1%
set /a SAT03=%SATOSHI:~2,1%
set /a SAT02=%SATOSHI:~1,1%
set /a SAT01=%SATOSHI:~0,1%
set /a S1=SAT04+(10*%SAT03%)+(100*%SAT02%)+(1000*%SAT01%)

REM Substract Fee
set /a NUL=0
set /a CARRY=0
set /a T4=%S4%
set /a T3=(%S3%-1)
if %T3% LSS 0 (
	set /a CARRY=1
	set /a T3=%T3%+10000
)
set /a T2=%S2%-%CARRY%
set /a CARRY=0
if %T2% LSS %NUL% (
	set /a CARRY=1
	set /a T2=%T2%+10000
)
set /a T1=%T1%-%CARRY%

rem convert INT to STRING
IF %T1% NEQ 0 set TRANSFER=%T1%
IF "%TRANSFER%" == "" (
  set TRANSFER=%T2%
) else (
  IF %T2% GEQ 1000 (
    set TRANSFER=%TRANSFER%%T2%
  ) else (
    IF %T2% LEQ 9 (
      set TRANSFER=%TRANSFER%000%T2%
    ) else (
      IF %T2% LEQ 99 (
        set TRANSFER=%TRANSFER%00%T2%
      ) else (
        IF %T2% LEQ 999 (
          set TRANSFER=%TRANSFER%0%T2%
        ) else (
          set TRANSFER=%TRANSFER%%T2%
        )
      )
    )
  )
)
IF %T3% GEQ 1000 (
  set TRANSFER=%TRANSFER%.%T3%
) else (
  IF %T3% GEQ 100 (
    set TRANSFER=%TRANSFER%0%T3%
  ) else (
    IF %T3% GEQ 10 (
      set TRANSFER=%TRANSFER%00%T3%
    ) else (
      set TRANSFER=%TRANSFER%000%T4%
    )
  )
)
IF %T2% GEQ 1000 (
  set TRANSFER=%TRANSFER%%T4%
) else (
  IF %T4% GEQ 100 (
    set TRANSFER=%TRANSFER%0%T4%
  ) else (
    IF %T4% GEQ 10 (
      set TRANSFER=%TRANSFER%00%T4%
    ) else (
      set TRANSFER=%TRANSFER%000%T4%
    )
  )
)

CLS
ECHO transfering %TRANSFER%
ECHO from %Z-ADDRESS%
ECHO to %T-ADDRESS%
ECHO .
REM Send z-balance minus fee to t-address
%FILELOCATION%/verus z_sendmany "%Z-ADDRESS%" "[{\"address\": \"%T-ADDRESS%\",\"amount\": %TRANSFER%}]"
ECHO.
set TRANSFER=
TIMEOUT /T 100
GOTO MENU

:Z_LISTADDRESSES
@cd %THIS_DIR%
%FILELOCATION%/verus z_listaddresses
ECHO.
TIMEOUT /T 10
GOTO MENU

:Z_GETOPERATIONSTATUS
@cd %THIS_DIR%
%FILELOCATION%/verus z_getoperationstatus
ECHO.
TIMEOUT /T 10
GOTO MENU

:LISTUNSPENT
@cd %THIS_DIR%
%FILELOCATION%/verus listunspent
ECHO.
TIMEOUT /T 240
GOTO MENU

:GETNETWORKINFO
@cd %THIS_DIR%
%FILELOCATION%/verus getnetworkinfo
ECHO.
TIMEOUT /T 20
GOTO MENU

:GETBLOCKCHAININFO
@cd %THIS_DIR%
%FILELOCATION%/verus getblockchaininfo
ECHO.
TIMEOUT /T 20
GOTO MENU

:GETDIFFICULTY
@cd %THIS_DIR%
%FILELOCATION%/verus getdifficulty
ECHO.
TIMEOUT /T 10
GOTO MENU

:HELP
@cd %THIS_DIR%
%FILELOCATION%/verus help
ECHO.
TIMEOUT /T 240
GOTO MENU

:strLen
setlocal enabledelayedexpansion
:strLen_Loop
   if not "!%1:~%len%!"=="" set /A len+=1 & goto :strLen_Loop
(endlocal & set %2=%len%)
goto :eof

:GET_CURRENT_DIR
@pushd %~dp0
@set THIS_DIR=%CD%
@popd

:eof
