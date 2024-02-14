@echo off
cls
for /f "tokens=1,2" %%i in (CompList.list) do call :BuildOneComp %%i %%j
goto EndBuildOneComp

:BuildOneComp
set tmpStr=%*
if /i not "%tmpStr:~0,2%"=="//" if /i not "%tmpStr:~0,1%"=="!" call CompOne.cmd %1 %2
set tmpStr=
goto :EOF
:EndBuildOneComp
