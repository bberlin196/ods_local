@echo off
REM Viscosity Batch script to disconnect 

set datetime_stamp=%Date% %Time% 
echo ======================================================================================
echo Start %datetime_stamp%
set ViscosityCCPath="C:\Program Files\Viscosity\ViscosityCC.exe"
set state=
set connname=
echo Get the 1th connections name
for /f "delims=" %%a in ('"%ViscosityCCPath% getname 1"') do @set connname=%%a
echo %connname%
echo Check the connection is not already started
for /f "delims=" %%a in ('"%ViscosityCCPath% getstate "%connname%""') do @set state=%%a
echo %state%
echo Disconnect 
%ViscosityCCPath% disconnect "%connname%"
echo Sleep 10 seconds to allow the action to happen
PING 127.0.0.1 -n 8 -w 60000 >NUL
for /f "delims=" %%a in ('"%ViscosityCCPath% getstate "%connname%""') do @set state=%%a
echo %state%
set datetime_stamp=%Date% %Time% 
echo End %datetime_stamp%
echo ======================================================================================