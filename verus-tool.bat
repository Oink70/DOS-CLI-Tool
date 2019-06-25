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
set T-ADDRESS=RWVuBdu5oHuAYuyivapaaUjbnSfAFHfsqJ
set Z-ADDRESS=zs1xc43f2v8cwnhy30jwe63f32zla39u69y409xq8s5sq8r8g23j24khpswr4k4fdr0wc7cw3zt5gq
set FILELOCATION=c:\Miners\verus-cli
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
IF %M%==ex GOTO EOF
IF %M%==6 GOTO LISTADDRESSGROUPINGS
IF %M%==5 GOTO GETWALLETINFO
IF %M%==s GOTO Z_SHIELDCOINBASE
IF %M%==z GOTO Z_GETBALANCE
IF %M%==r GOTO Z_MERGETOADDRESS
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
For /F "delims=" %%I in ('%FILELOCATION%/verus z_getbalance "%Z-ADDRESS%"') Do Set BALANCE=%%I


rem %FILELOCATION%/verus z_sendmany "%Z-ADDRESS%" "[{\"address\": \"%T-ADDRESS%"\,\"amount\":%BALANCE%}]"
ECHO.
TIMEOUT /T 100
GOTO MENU

:Z_LISTADDRESSES
@cd %THIS_DIR%
%FILELOCATION%/verus z_listaddresses
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

:GET_CURRENT_DIR
@pushd %~dp0
@set THIS_DIR=%CD%
@popd
