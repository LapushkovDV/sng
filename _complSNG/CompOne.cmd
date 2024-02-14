@echo off
rem ********************************************************************************
rem ���ઠ ������ ��������� ERP
rem ********************************************************************************
set PathSave=%PATH%
if exist stop.sbo goto End
call SetPath.cmd
@echo off
set CompPath=%1
set CompFile=%1
set CompProj=%1
if "%2"=="sng" (
  if not "%CompFile:~0,3%"=="SNG" set CompFile=SNG_%1
  if "%CompFile:~0,12%"=="SNG_HisLoad\" (
    for /d %%1 in (%RepoSNG%\src\*.*) do if exist %%1\%1\%CompFile:SNG_HisLoad\=%.prj set CompPath=%%1\%1
    set CompFile=%CompFile:SNG_HisLoad\=%
	set CompProj=%CompProj:SNG_HisLoad\=%
  ) else (
    for /d %%1 in (%RepoSNG%\src\*.*) do if exist %%1\%1\%1.prj set CompPath=%%1\%1
  )
)
if "%2"=="tmp" (
  for /d %%1 in (%RepoSNG%\tempGal\*.*) do if exist %%1\%1\%1.prj set CompPath=%%1\%1
)
if "%2"=="gal" (
  for /d %%1 in (%RepoGal%\CompSrc\*.*) do if exist %%1\%1\%1.prj set CompPath=%%1\%1
)
rem echo %CompPath%
rem echo %CompFile%
rem echo %CompProj%
rem pause

set NameCfg=%2
if "%NameCfg%"=="" set NameCfg=vip

echo ���ઠ %CompFile% > vip.sbo
rem �����㥬 �६�
rem call DiffTime.bat /SaveTime
set bTime=%time%
set bTime=%bTime: =%
if "%bTime:~2,1%"==":" (
  set bTime=%bTime:~0,8%
) else (
  set bTime=0%bTime:~0,7%
)
if not exist %PathLog% md %PathLog%
if not exist %PathCfg% md %PathCfg%
if not exist %PathInc% md %PathInc%
if not exist %PathSum% md %PathSum%
if not exist %PathTmp% md %PathTmp%
if not exist %CompPath%\%CompProj%.prj goto EndSboRes
if not exist %PathCfg%\%NameCfg%.cfg call MakeCfg.cmd %NameCfg%
if exist atlerror.log del atlerror.log
if exist %PathLog%\atlerror.%CompFile%.log del %PathLog%\atlerror.%CompFile%.log
if exist %PathInc%\%CompFile%.fnc del %PathInc%\%CompFile%.fnc
echo.
echo ===============================================================================
echo ���ઠ ��������� %CompFile% (%NameCfg%)
echo %CompPath%\%CompProj%.prj
echo ===============================================================================
rem ��ନ஢���� 䠩�� OpenResources.cfg
if exist %CompFile%.OpenResourcesErr.log del %CompFile%.OpenResourcesErr.log
if exist OpenResources.cfg del OpenResources.cfg
set ErrExistIncludeRes=no
echo ! ������砥�� ������ �ᯮ��㥬� �� ᡮથ ��������� %CompFile%. >> OpenResources.cfg
if not exist %CompPath%\OpenResources.lst goto EndCreateOpenResources_cfg
echo ��ନ஢���� ���䨣��樮����� 䠩�� OpenResources.cfg
set OpenResourcesListFullPath=%CompPath%\OpenResources.lst
echo ��ࠡ��뢠����: %OpenResourcesListFullPath%
echo �� ᡮથ ��������� ����������� ᫥���騥 ������ �����⨪�:
set /a OpenResourcesStrNum=0
setlocal ENABLEDELAYEDEXPANSION
for /f "tokens=1,2" %%i in (%OpenResourcesListFullPath%) do (
  set /a OpenResourcesStrNum=OpenResourcesStrNum+1
  if not "%%i"=="" (
    echo      %%i
    echo OpenResources=%PathErp%\%%i >> OpenResources.cfg
    rem �஢�ઠ �� ����稥 䠩�� �����
    if not exist %PathErp%\%%i (
      set ErrExistIncludeRes=yes
      echo        [x] �訡��: ��������� �����: %PathErp%\%%i ���.!OpenResourcesStrNum!
      echo [x] �訡��: ��������� �����: %PathErp%\%%i 㪠����� � %OpenResourcesListFullPath% ���.!OpenResourcesStrNum!>> %CompFile%.OpenResourcesErr.log
    )
  )
)
setlocal DISABLEDELAYEDEXPANSION
set OpenResourcesListFullPath=
echo ���䨣��樮��� 䠩� OpenResources.cfg ��ନ஢��...
echo -------------------------------------------------------------------------------
:EndCreateOpenResources_cfg
rem ��� ᡮન �� �⫠��� 6.x-���ᨩ
set ExtraDefine=
if "%AtlVer:~0,1%"=="6" set ExtraDefine=/def:Atl60
echo �������� ����� %PathRes%\%CompFile%.res
echo -------------------------------------------------------------------------------
rem ��� ��������⭮� ᡮન ��� �� ��ப�
%PathSup%\vip.exe %CompPath%\%CompProj%.prj /vip.componentname:%CompFile% /r:%PathRes%\%CompFile%.res /c:%PathCfg%\%NameCfg%.cfg /f %ExtraDefine%
set ExtraDefine=
echo\
if exist %PathRes%\%CompFile%.res echo ������ ᮡ࠭ %PathRes%\%CompFile%.res
echo -------------------------------------------------------------------------------
if errorlevel 1 goto ERR
if exist atlerror.log del goto ERR
:EndSboRes
if not exist %CompPath%\XLS goto EndCopyXLS
echo ����஢���� XLS-���⮢
echo     ��: %CompPath%\XLS
echo     � : %PathRes%\XLS\%CompFile%
xcopy %CompPath%\XLS\*.* %PathRes%\XLS\%CompFile%\*.* /E /Y /R /I /F
echo     ��: %CompPath%\XLS
echo     � : %PathRes%\XLS\Distr
xcopy %CompPath%\XLS\*.* %PathRes%\XLS\Distr\%CompFile%\*.* /E /Y /R /I /F
echo -------------------------------------------------------------------------------
:EndCopyXLS
if not exist %CompPath%\Exe goto EndCopyEXE
echo ����஢���� Exe
echo     ��: %CompPath%\Exe
echo     � : %PathRes%
xcopy %CompPath%\Exe %PathRes% /E /Y /R /I
echo -------------------------------------------------------------------------------
:EndCopyEXE
:SboFR3
set ErrInFastReport=
if not exist %CompPath%\fr3 goto EndSboFR3
rem ����� FastReport
echo ���ઠ ���⮢ FastReport3 ���������� %CompFile%
if exist %CompPath%\fr3 for /r %CompPath%\fr3 %%i in (.) do %PathSup%\frres.exe /to /r:%PathRes%\%CompFile%.res /source:%%~fi
if not errorlevel 0 set ErrInFastReport=yes
if "%ErrInFastReport%"=="yes" (
  echo �����㦥�� �訡�� �� ����饭�� FastReport3-���⮢ � �����.
  echo �����㦥�� �訡�� �� ����饭�� FastReport3-���⮢ � �����. >> frf_res.log
)
echo �஢�ઠ ����饭�� FastReport3-���⮢ � �����:
set Fr3TempCheckUpFolder=%PathTmp%\Fr3TempCheckUpFolder\
if exist %Fr3TempCheckUpFolder% rmdir /s /q %Fr3TempCheckUpFolder%
if not exist %Fr3TempCheckUpFolder% md %Fr3TempCheckUpFolder%
if exist frf_res_.log del frf_res_.log
if exist frf_res.log ren frf_res.log frf_res_.log
%PathSup%\frres.exe /from /r:%PathRes%\%CompFile%.res /source:%Fr3TempCheckUpFolder% > nul
if exist frf_res.log del frf_res.log
if exist frf_res_.log ren frf_res_.log frf_res.log
echo �஢�ઠ ����饭�� 䠩��� � �����:>> frf_res.log
set /a CountCheckUpFR3Files=0
for /r "%CompPath%\fr3\" %%i in ("*.fr3") do (
  set /a CountCheckUpFR3Files=CountCheckUpFR3Files+1
  if exist "%Fr3TempCheckUpFolder%%%~nxi" (
    echo ���� ��������� � �����: %%~nxi>> frf_res.log
    call :CheckUpSize %%~zi "%Fr3TempCheckUpFolder%%%~nxi"
  ) else (
    echo [x] �訡��: ���� ��������� � �����: %%~nxi>> frf_res.log
    set ErrInFastReport=yes
  )
)
for /r "%Fr3TempCheckUpFolder%" %%i in ("*.fr3") do (
  if not exist "%CompPath%\fr3\%%~nxi" (
    echo [i] ���ଠ��: ���� ��������� � ���筨��, �� ��������� � �����: %%~nxi>> frf_res.log
    set /a CountCheckUpFR3Files=CountCheckUpFR3Files+1
  )
)
if exist %Fr3TempCheckUpFolder% rmdir /s /q %Fr3TempCheckUpFolder%
goto EndCheckUpSize
:CheckUpSize
if not "%1"=="%~z2" (
  echo [x] �訡��: ������ 䠩�� 㯠��������� � ����� [%~z2] �⫨砥��� �� ��室���� [%CompFile%]: "%~nx2">> frf_res.log
  set ErrInFastReport=yes
)
goto :EOF
:EndCheckUpSize
echo �஢�७� 䠩���: %CountCheckUpFR3Files% >> frf_res.log
if /i "%ErrInFastReport%"=="yes" (
  set errorInPatch=yes
  echo �����㦥�� �訡�� �� ᡮથ FastReport3-���⮢:
  find "[x] �訡��: " "frf_res.log" | find "[x] �訡��: "
) else (
  echo Ok. �஢�७� 䠩���: %CountCheckUpFR3Files%.
)
find "[i] ���ଠ��: " "frf_res.log" | find "[i] ���ଠ��:" > nul
if not ErrorLevel 1 (
  echo �����㦥�� 䠩�� ���������騥 � ���筨��, �� ��������� � �����:
  find "[i] ���ଠ��: " "frf_res.log" | find "[i] ���ଠ��:"
)
if /i "%ErrInFastReport%"=="yes" (
  echo �஢�७� 䠩���: %CountCheckUpFR3Files%
)
echo -------------------------------------------------------------------------------
:EndSboFR3
goto EndErr
:Err
echo �訡�� �� ᡮથ. ��������� %CompFile% > error.sbo
goto EndErr
:Novar
rem call novar.bat
:EndErr
if exist %PathRes%\%CompFile%.fnc copy %PathRes%\%CompFile%.fnc %PathInc%\*.fnc > nul
if exist %PathRes%\%CompFile%.fnc del  %PathRes%\%CompFile%.fnc
if "%ErrExistIncludeRes%"=="yes" if exist %CompFile%.OpenResourcesErr.log (
  copy /b /y %CompFile%.OpenResourcesErr.log+vip_res.log TempVip_res.log>nul
  copy /y TempVip_res.log vip_res.log>nul
  del %CompFile%.OpenResourcesErr.log
  del TempVip_res.log
)
if exist %PathLog%\atlerror.%CompFile%.log del %PathLog%\atlerror.%CompFile%.log
if exist atlerror.log move /y atlerror.log %PathLog%\atlerror.%CompFile%.log
if exist macro.lst move /y macro.lst %PathLog%\%CompFile%.lst
if exist %PathLog%\%CompFile%.log del %PathLog%\%CompFile%.log
if exist vip_res.log echo ��� ᡮન:           %PathLog%\%CompFile%.log
if exist vip_res.log copy vip_res.log %PathLog%\%CompFile%.log>nul
if exist VipResCheckSums.csv echo ����஫�� �㬬�:    %PathSum%\%CompFile%.csv
if exist VipResCheckSums.csv copy /y VipResCheckSums.csv %PathSum%\%CompFile%.csv>nul
if exist VipResCheckSums.csv del VipResCheckSums.csv
if exist frf_res.log echo ��� ᡮન FR3:       %PathLog%\%CompFile%.FRRes.log
if exist frf_res.log copy /y frf_res.log %PathLog%\%CompFile%.FRRes.log>nul
if exist vip.sbo del vip.sbo
if exist atlantis.res del atlantis.res
if exist vip_res.log del vip_res.log
if exist frf_res.log del frf_res.log
if exist OpenResources.cfg del OpenResources.cfg
if exist logs rmdir logs /s /q
rem ����஢���� ᮡ࠭���� ����� � ࠡ�稩 ��⠫��
if "%2"=="gal" (
  echo ����஢���� ����� � %PathErp%\%CompFile%.res
  if exist %PathRes%\%CompFile%.res copy /y %PathRes%\%CompFile%.res %PathErp%\%CompFile%.res
) else (
  echo ����஢���� ����� � %PathErp%\SNG\%CompFile%.res
  if exist %PathRes%\%CompFile%.res copy /y %PathRes%\%CompFile%.res %PathErp%\SNG\%CompFile%.res
  rem echo ����஢���� ����� � %PathExe%\SNG\%CompFile%.res
  rem if exist %PathRes%\%CompFile%.res copy /y %PathRes%\%CompFile%.res %PathExe%\SNG\%CompFile%.res
)
rem �����㥬 �६�
rem call DiffTime.bat ��������� %1.prj � %1.res - [%~nx0]>>%PathLog%\time.sbo
set eTime=%time%
set eTime=%eTime: =%
if "%eTime:~2,1%"==":" (
  set eTime=%eTime:~0,8%
) else (
  set eTime=0%eTime:~0,7%
)
echo -------------------------------------------------------------------------------
echo �६� ᡮન �����: %bTime% - %eTime%
:End
echo ===============================================================================
PATH=%PATHSAVE%
