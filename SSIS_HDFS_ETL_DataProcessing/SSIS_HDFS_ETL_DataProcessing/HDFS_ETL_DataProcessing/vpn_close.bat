@echo off
REM Viscosity Batch script to connect the 1-st connection,
REM Wait until the connection has connected,
REM And then show the state

set datetime_stamp=%Date% %Time% 
echo ======================================================================================
echo Start %datetime_stamp%
set ViscosityCCPath="C:\Program Files\Viscosity\ViscosityCC.exe"
set state=Connected
echo 555 %state%
set connname=
echo Get the 1-t connections name
for /f "delims=" %%a in ('"%ViscosityCCPath% getname 1"') do @set connname=%%a
echo %connname%
echo Check the connection is not already started
for /f "delims=" %%a in ('"%ViscosityCCPath% getstate "%connname%""') do @set state=%%a
echo %state%
if %state%==Connected goto :loop
echo Disconnect just in case if VPN got stuck on “Connecting” state
rem %ViscosityCCPath% disconnect "%connname%"
echo Sleep 120 seconds to allow the action to happen
PING 127.0.0.1 -n 8 -w 60000 >NUL
PING 127.0.0.1 -n 8 -w 60000 >NUL
PING 127.0.0.1 -n 8 -w 60000 >NUL
PING 127.0.0.1 -n 8 -w 60000 >NUL
PING 127.0.0.1 -n 8 -w 60000 >NUL
PING 127.0.0.1 -n 8 -w 60000 >NUL
PING 127.0.0.1 -n 8 -w 60000 >NUL
PING 127.0.0.1 -n 8 -w 60000 >NUL
PING 127.0.0.1 -n 8 -w 60000 >NUL
PING 127.0.0.1 -n 8 -w 60000 >NUL
PING 127.0.0.1 -n 8 -w 60000 >NUL
PING 127.0.0.1 -n 8 -w 60000 >NUL
:start_con
echo Start the connection
%ViscosityCCPath% connect "%connname%"
echo Sleep 60 seconds to allow the connection to happen
set datetime_stamp=%Date% %Time% 
echo End %datetime_stamp%
PING 127.0.0.1 -n 8 -w 360000 >NUL
set datetime_stamp=%Date% %Time% 
echo End %datetime_stamp%
:loop
echo Sleep 120 seconds to allow the action to happen
PING 127.0.0.1 -n 8 -w 60000 >NUL
PING 127.0.0.1 -n 8 -w 60000 >NUL
PING 127.0.0.1 -n 8 -w 60000 >NUL
PING 127.0.0.1 -n 8 -w 60000 >NUL
PING 127.0.0.1 -n 8 -w 60000 >NUL
PING 127.0.0.1 -n 8 -w 60000 >NUL
PING 127.0.0.1 -n 8 -w 60000 >NUL
PING 127.0.0.1 -n 8 -w 60000 >NUL
PING 127.0.0.1 -n 8 -w 60000 >NUL
PING 127.0.0.1 -n 8 -w 60000 >NUL
PING 127.0.0.1 -n 8 -w 60000 >NUL
PING 127.0.0.1 -n 8 -w 60000 >NUL
for /f "delims=" %%a in ('"%ViscosityCCPath% getstate "%connname%""') do @set state=%%a
echo %state%
if NOT %state%==Connected goto :start_con
set datetime_stamp=%Date% %Time% 
echo End %datetime_stamp%
echo ======================================================================================