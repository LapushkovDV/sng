@echo off
rem ********************************************************************************
rem �������� ���䨣��樮����� 䠩�� ��� ᡮન ���������
rem ********************************************************************************
call SetPath.cmd
@echo off

set FileCfg=%PathCfg%\%1.cfg
if exist %FileCfg% del %FileCfg%
echo ===============================================================================
echo �������� ���䨣��樮����� 䠩�� ��� ᡮન
echo ����: %FileCfg%
rem ------------------
set bTime=%time%
set bTime=%bTime: =%
if "%bTime:~2,1%"==":" (
  set bTime=%bTime:~0,8%
) else (
  set bTime=0%bTime:~0,7%
)
echo //----------------------------------------------------------------------------- >> %FileCfg%
echo // ���䨣��樮��� 䠩� >> %FileCfg%
echo //----------------------------------------------------------------------------- >> %FileCfg%
echo ! ������祭�� � �� � ��業��� >> %FileCfg%
echo #include DataBase.cfg >> %FileCfg%
echo. >> %FileCfg%
echo ! ��� ���㠫���樨 �� 㬮�砭�� (NUMERIC, INDICATOR ��� ROTATE) >> %FileCfg%
echo System.VisualType=NUMERIC >> %FileCfg%
echo ! ������� ������ (����஥ ᦠ⨥ �⪫�砥�) >> %FileCfg%
echo System.ResourceFastCompress=Off >> %FileCfg%
echo ! ����� 㪠����� ��� �� ��⠫�� ��� �ନ஢���� ����� �� ���⠭������ ������, ���ਬ�� atlerror.log. 101.62710 >> %FileCfg%
echo Files.LogFilesDirectory=%PathLog%  >>%FileCfg%
echo ! ���� �� ��⠫��, ��� ���� �࠭����� ����� � ��㣨� ��室�� ����� >> %FileCfg%
echo Files.OutputFilesDirectory=%PathInc% >> %FileCfg%
echo ! ���� �� ��⠫�� ��� ������� �६���� 䠩�� (���ਬ��, C:\TMP) >> %FileCfg%
echo Files.TmpFilesDirectory="%PathTmp%" >> %FileCfg%
echo DataBase.UserTablesDirectory=%PathTmp%\MTcache\ >> %FileCfg%
echo. >> %FileCfg%
echo [Compilers] >> %FileCfg%
echo ! �஢��� �뤠� �������⨪� (0-3): 2 - Error, Warning, Hint >> %FileCfg%
echo   ErrorLevel=2 >> %FileCfg%
echo ! ����� ��������樨 �뤠� ���ଠ樨 � ����� �������樨 � 楫�� �� �᪮७�� >> %FileCfg%
echo   MinVisual=On >> %FileCfg%
echo ! ��ନ஢��� Include-䠩�� ��� ��᪠�� � १���� �������樨 >> %FileCfg%
echo   WriteIncludes=Off >> %FileCfg%
echo ! ��㦥��� ����� >> %FileCfg%
echo   SubServientResource='atlantis.res' >> %FileCfg%
echo ! �� ������� 䠩��� �� ��᪥, �᪠�� ⠪�� 䠩�� � �����४���� >> %FileCfg%
echo   SubDir=Off >> %FileCfg%
echo ! ������� �������樨 ��࠭��� � ����� >> %FileCfg%
echo   WriteToResource=On >> %FileCfg%
echo ! ��ନ஢��� ���⨭�� � १���� �������樨 >> %FileCfg%
echo   WriteListing=On >> %FileCfg%
echo ! ���⪨� �ଠ� �뢮�� ᮮ�饭�� >> %FileCfg%
echo   ShortMessages=On >> %FileCfg%
echo ! ��� 䠩�� ��� �࠭���� ��ନ஢����� ����஫��� �㬬 >> %FileCfg%
echo   CSVlogFile=VipResCheckSums.csv >> %FileCfg%
echo ! ��४������஢��� �� 䠩��, � �� ⮫쪮 �������訥�� � ��諮�� ࠧ� >> %FileCfg%
echo   Build=On >> %FileCfg%
echo ! ����� ����� ��। �������樥� >> %FileCfg%
echo   ClearResource=On >> %FileCfg%
echo ! �����祭�� : �������஢��� �� ������� 䠩��, � �� �� ��ࢮ� �訡�� >> %FileCfg%
echo   Full=On >> %FileCfg%
echo ! ��� ������ �� ��業��஢����� ����䥩ᮢ �� �������樨 >> %FileCfg%
echo   DisableIfcLicWarnings=Off >> %FileCfg%
if "%AtlVer:~0,1%"=="5" (
  rem ��ࠬ��� ���५ ��� �⫠��� 6.0
  echo ! �।���⥭�� ����⠭⠬ �� �������樨 >> %FileCfg%
  echo   ConstantPreference=Off >> %FileCfg%
)
echo ! ����� �������樨 �뤠�� �� ���᮫� ᯨ᮪ ���������� 䠩��� >> %FileCfg%
echo   CheckModifyOnly=Off >> %FileCfg%
echo ! ���࠭��� ���ଠ�� � ��᫥������� ����䥩ᮢ >> %FileCfg%
echo   InhSaveLevel=3 >> %FileCfg%
echo. >> %FileCfg%
echo [Vip] >> %FileCfg%
echo ! ��᪠ �।�०����� �� �ਢ������ ⨯��: 0-���; 1-� 楫��᫥��� ⨯��; >> %FileCfg%
echo ! 2-� ����⢥��� ⨯��; 4-� ��ப��� ⨯��; 8-� ⨯�� ���-�६�; >> %FileCfg%
echo   BaseTypesWarning=14 >> %FileCfg%
echo ! � 9.1 �ᯮ������ �� ���������� ᫮���� >> %FileCfg%
echo   NoTablesInComponent=On >> %FileCfg%
echo ! ���ઠ �⫠��筮� ���ଠ樨 >> %FileCfg%
echo   Debug=1 >> %FileCfg%
echo   LocalDebug=1 >> %FileCfg%
rem echo ! �ᨫ����� ��ண���� �몠. 102.54641 >> %FileCfg%
rem echo   StrictVip=On >>%FileCfg%
rem echo ! �।�०����� �᫨ � ���� ����砥��� ���⮩ ����. 102.49896 >> %FileCfg%
rem echo   EmptyBlockWarnings=On >> %FileCfg%
rem echo ! ������� ������� ��� ����⠭� 102.47247 � 102.46935 >> %FileCfg%
rem echo   IgnoreNewConstants=On >> %FileCfg%
echo ! �⪫�祭�� �।�०����� �� �஡���� 102.138961 >> %FileCfg%
echo   InitVarWarnings=Off >> %FileCfg%
echo. >> %FileCfg%

rem ���⨭� ���ப�������� ��� ��������樨 �訡�� ᡮન
if "%2"=="Macro" (
  echo [Macro] >> %FileCfg%
  echo   ListEnable=On >> %FileCfg%
  echo   ListFileName=macro.lst >> %FileCfg%
  echo   ShowSource=On >> %FileCfg%
  echo   DefineSource=Off >> %FileCfg%
  echo. >> %FileCfg%
)
echo ! �������, ��⮬���᪨ ���뢠�騥�� �� ���� �ணࠬ�� >> %FileCfg%
echo [System] >> %FileCfg%
echo ! �⠭����� ������, ������砥�� �� ᡮથ ��� ���������: >> %FileCfg%
echo   OpenResources=%PathErp%\C_ExtFun.res >> %FileCfg%
echo   OpenResources=%PathErp%\C_StatLine.res >> %FileCfg%
echo ! �������, ������砥�� �� ᡮથ �����⭮�� ���������: >> %FileCfg%
echo #include OpenResources.cfg >> %FileCfg%
echo. >> %FileCfg%

echo ! ��� ��� ���᪠ Include-䠩��� >> %FileCfg%
rem �������਩ ��� � �ᥬ� �������묨
if "%1"=="sng" (
  for /r %RepoSNG%\src %%i in (.) do @echo /i:"%%~fi"; >> %FileCfg%
)
rem �६���� ���ᨨ �⠭������ ����ᮢ � ९����ਨ ��� � �ᥬ� �������묨
if "%1"=="tmp" (
  for /r %RepoSNG%\tempGal %%i in (.) do @echo /i:"%%~fi"; >> %FileCfg%
)
rem �������਩ �����⨪� � �ᥬ� �������묨
if "%1"=="gal" (
  for /r %RepoGal%\CompSrc %%i in (.) do @echo /i:"%%~fi"; >> %FileCfg%
)
rem ��⠫�� INC � �ᥬ� �������묨
for /r %RepoGal%\inc %%i in (.) do @echo /i:"%%~fi"; >> %FileCfg%
rem ��業��஢����
for /r %RepoGal%\Components\Lih %%i in (.) do @echo /i:"%%~fi"; >> %FileCfg%
rem *.fnc 䠩�� (IncVipLo)
for /r %PathInc% %%i in (.) do @echo /i:"%%~fi:"; >> %FileCfg%
rem �⫠���
for /r %PathAtl%\GEN %%i in (.) do @echo /i:"%%~fi"; >> %FileCfg%
for /r %PathAtl%\Source %%i in (.) do @echo /i:"%%~fi"; >> %FileCfg%
rem �������਩ �����⨪� ��� vip � �ᥬ� �������묨
if "%1"=="sng" (
  for /r %PathSrc%\CompSrc %%i in (.) do @echo /i:"%%~fi"; >> %FileCfg%
)
rem �������਩ �����⨪� � �ᥬ� �������묨
if "%1"=="tmp" (
  for /r %RepoGal%\CompSrc %%i in (.) do @echo /i:"%%~fi"; >> %FileCfg%
)
rem ��� � ����ᠬ
echo /i:"%PathRes%"; >> %FileCfg%
echo /i:"%PathErp%"; >> %FileCfg%
rem ------------------
set eTime=%time%
set eTime=%eTime: =%
if "%eTime:~2,1%"==":" (
  set eTime=%eTime:~0,8%
) else (
  set eTime=0%eTime:~0,7%
)
echo �६� �ନ஢����: %bTime% - %eTime%
echo ===============================================================================
