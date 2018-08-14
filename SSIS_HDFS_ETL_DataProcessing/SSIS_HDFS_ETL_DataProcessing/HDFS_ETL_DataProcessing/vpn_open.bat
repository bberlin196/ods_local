@echo off
REM Viscosity Batch script to connect the 1-st connection,
REM Wait until the connection has connected,
REM And then show the state

set datetime_stamp=%Date% %Time% 
echo ======================================================================================
echo Start %datetime_stamp%
set ViscosityCCPath="C:\Program Files\Viscosity\ViscosityCC.exe"

REM set connname=
REM echo Get the 1-t connections name
REM for /f "delims=" %%a in ('"%ViscosityCCPath% getname 1"') do @set connname=%%a
REM echo %connname%
REM echo Check the connection is not already started
REM for /f "delims=" %%a in ('"%ViscosityCCPath% getstate "%connname%""') do @set state=%%a
REM echo %state%
REM if %state%==Connected goto :loop
REM echo Disconnect just in case if VPN got stuck on “Connecting” state
REM  %ViscosityCCPath% disconnect "%connname%"
echo Start the connection
%ViscosityCCPath% connect "%connname%"
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
set datetime_stamp=%Date% %Time% 
echo End %datetime_stamp%
echo ======================================================================================