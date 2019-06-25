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
set SATOSHIFEE=0000000000010000
rem *************************************************************
rem ***           End: parameters specific to users           ***
rem *************************************************************

:Z_MERGETOADDRESS
@cd %THIS_DIR%
@SETLOCAL EnableDelayedExpansion
For /F "delims=" %%I in ('%FILELOCATION%/verus z_getbalance "%Z-ADDRESS%"') Do Set BALANCE=%%I
echo The Balance is %BALANCE%
call :strLen BALANCE LENGTH
set SATOSHI=%BALANCE:.=%
SET /a i=%LENGTH%
:loop
if %i% equ 17 goto :endfor
set SATOSHI=0%SATOSHI%
set /a "i+=1"
goto :loop
:endfor

Echo %SATOSHI%

set /a SAT13_16=%SATOSHI:~12,4%
set /a SAT09_12=%SATOSHI:~8,4%
set /a SAT05_08=0010
:%SATOSHI:~4,4%
set /a SAT01_04=%SATOSHI:~0,4%
Echo 1. String %SATOSHI:~12,4% should equal %SAT13_16%
Echo 2. String %SATOSHI:~8,4% should equal %SAT09_12%
Echo 3. String %SATOSHI:~4,4% should equal %SAT05_08%
Echo 4. String %SATOSHI:~0,4% should equal %SAT01_04%


exit /b

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
