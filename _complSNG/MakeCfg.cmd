@echo off
rem ********************************************************************************
rem Создание конфигурационного файла для сборки компонента
rem ********************************************************************************
call SetPath.cmd
@echo off

set FileCfg=%PathCfg%\%1.cfg
if exist %FileCfg% del %FileCfg%
echo ===============================================================================
echo Создание конфигурационного файла для сборки
echo Файл: %FileCfg%
rem ------------------
set bTime=%time%
set bTime=%bTime: =%
if "%bTime:~2,1%"==":" (
  set bTime=%bTime:~0,8%
) else (
  set bTime=0%bTime:~0,7%
)
echo //----------------------------------------------------------------------------- >> %FileCfg%
echo // Конфигурационный файл >> %FileCfg%
echo //----------------------------------------------------------------------------- >> %FileCfg%
echo ! Подключение к БД и лицензия >> %FileCfg%
echo #include DataBase.cfg >> %FileCfg%
echo. >> %FileCfg%
echo ! Тип визуализации по умолчанию (NUMERIC, INDICATOR или ROTATE) >> %FileCfg%
echo System.VisualType=NUMERIC >> %FileCfg%
echo ! Сжимать ресурсы (быстрое сжатие отключаем) >> %FileCfg%
echo System.ResourceFastCompress=Off >> %FileCfg%
echo ! Явное указание пути на каталог для формирований логов при нестандартных ситуациях, например atlerror.log. 101.62710 >> %FileCfg%
echo Files.LogFilesDirectory=%PathLog%  >>%FileCfg%
echo ! Путь на каталог, где будут храниться отчеты и другие выходные данные >> %FileCfg%
echo Files.OutputFilesDirectory=%PathInc% >> %FileCfg%
echo ! Путь на каталог где ведутся временные файлы (например, C:\TMP) >> %FileCfg%
echo Files.TmpFilesDirectory="%PathTmp%" >> %FileCfg%
echo DataBase.UserTablesDirectory=%PathTmp%\MTcache\ >> %FileCfg%
echo. >> %FileCfg%
echo [Compilers] >> %FileCfg%
echo ! Уровень выдачи диагностики (0-3): 2 - Error, Warning, Hint >> %FileCfg%
echo   ErrorLevel=2 >> %FileCfg%
echo ! Режим минимизации выдачи информации о процессе компиляции с целью ее ускорения >> %FileCfg%
echo   MinVisual=On >> %FileCfg%
echo ! Формировать Include-файлы для Паскаля в результате компиляции >> %FileCfg%
echo   WriteIncludes=Off >> %FileCfg%
echo ! Служебный ресурс >> %FileCfg%
echo   SubServientResource='atlantis.res' >> %FileCfg%
echo ! При задании файлов по маске, искать также файлы в поддиректориях >> %FileCfg%
echo   SubDir=Off >> %FileCfg%
echo ! Результат компиляции сохранять в ресурсе >> %FileCfg%
echo   WriteToResource=On >> %FileCfg%
echo ! Формировать листинги в результате компиляции >> %FileCfg%
echo   WriteListing=On >> %FileCfg%
echo ! Короткий формат вывода сообщений >> %FileCfg%
echo   ShortMessages=On >> %FileCfg%
echo ! Имя файла для хранения сформированных контрольных сумм >> %FileCfg%
echo   CSVlogFile=VipResCheckSums.csv >> %FileCfg%
echo ! Перекомпилировать все файлы, а не только изменившиеся с прошлого раза >> %FileCfg%
echo   Build=On >> %FileCfg%
echo ! Очищать ресурс перед компиляцией >> %FileCfg%
echo   ClearResource=On >> %FileCfg%
echo ! Назначение : Компилировать все заданные файлы, а не до первой ошибки >> %FileCfg%
echo   Full=On >> %FileCfg%
echo ! Для выявления не лицензированных интерфейсов при компиляции >> %FileCfg%
echo   DisableIfcLicWarnings=Off >> %FileCfg%
if "%AtlVer:~0,1%"=="5" (
  rem Параметр устарел для Атлантиса 6.0
  echo ! Предпочтение константам при компиляции >> %FileCfg%
  echo   ConstantPreference=Off >> %FileCfg%
)
echo ! вместо компиляции выдает на консоль список измененных файлов >> %FileCfg%
echo   CheckModifyOnly=Off >> %FileCfg%
echo ! Сохранять информацию о наследовании интерфейсов >> %FileCfg%
echo   InhSaveLevel=3 >> %FileCfg%
echo. >> %FileCfg%
echo [Vip] >> %FileCfg%
echo ! Маска предупреждения при приведении типов: 0-нет; 1-к целочисленным типам; >> %FileCfg%
echo ! 2-к вещественным типам; 4-к строковым типам; 8-к типам дата-время; >> %FileCfg%
echo   BaseTypesWarning=14 >> %FileCfg%
echo ! В 9.1 используется не компонентный словарь >> %FileCfg%
echo   NoTablesInComponent=On >> %FileCfg%
echo ! Сборка отладочной информации >> %FileCfg%
echo   Debug=1 >> %FileCfg%
echo   LocalDebug=1 >> %FileCfg%
rem echo ! Усиливает строгость языка. 102.54641 >> %FileCfg%
rem echo   StrictVip=On >>%FileCfg%
rem echo ! Предупреждение если в коде встречается пустой блок. 102.49896 >> %FileCfg%
rem echo   EmptyBlockWarnings=On >> %FileCfg%
rem echo ! Запретить генерацию всех констант 102.47247 и 102.46935 >> %FileCfg%
rem echo   IgnoreNewConstants=On >> %FileCfg%
echo ! Отключение предупреждений по проблеме 102.138961 >> %FileCfg%
echo   InitVarWarnings=Off >> %FileCfg%
echo. >> %FileCfg%

rem Листинг макрокомпилятора для локализации ошибок сборки
if "%2"=="Macro" (
  echo [Macro] >> %FileCfg%
  echo   ListEnable=On >> %FileCfg%
  echo   ListFileName=macro.lst >> %FileCfg%
  echo   ShowSource=On >> %FileCfg%
  echo   DefineSource=Off >> %FileCfg%
  echo. >> %FileCfg%
)
echo ! Ресурсы, автоматически открывающиеся при старте программы >> %FileCfg%
echo [System] >> %FileCfg%
echo ! Стандартные ресурсы, подключаемые при сборке всех компонент: >> %FileCfg%
echo   OpenResources=%PathErp%\C_ExtFun.res >> %FileCfg%
echo   OpenResources=%PathErp%\C_StatLine.res >> %FileCfg%
echo ! Ресурсы, подключаемые при сборке конкретного компонента: >> %FileCfg%
echo #include OpenResources.cfg >> %FileCfg%
echo. >> %FileCfg%

echo ! Пути для поиска Include-файлов >> %FileCfg%
rem Репозитарий СНГ со всеми вложенными
if "%1"=="sng" (
  for /r %RepoSNG%\src %%i in (.) do @echo /i:"%%~fi"; >> %FileCfg%
)
rem Временные версии стандартных ресурсов в репозитарии СНГ со всеми вложенными
if "%1"=="tmp" (
  for /r %RepoSNG%\tempGal %%i in (.) do @echo /i:"%%~fi"; >> %FileCfg%
)
rem Репозитарий Галактики со всеми вложенными
if "%1"=="gal" (
  for /r %RepoGal%\CompSrc %%i in (.) do @echo /i:"%%~fi"; >> %FileCfg%
)
rem Каталог INC со всеми вложенными
for /r %RepoGal%\inc %%i in (.) do @echo /i:"%%~fi"; >> %FileCfg%
rem Лицензирование
for /r %RepoGal%\Components\Lih %%i in (.) do @echo /i:"%%~fi"; >> %FileCfg%
rem *.fnc файлы (IncVipLo)
for /r %PathInc% %%i in (.) do @echo /i:"%%~fi:"; >> %FileCfg%
rem Атлантис
for /r %PathAtl%\GEN %%i in (.) do @echo /i:"%%~fi"; >> %FileCfg%
for /r %PathAtl%\Source %%i in (.) do @echo /i:"%%~fi"; >> %FileCfg%
rem Репозитарий Галактики без vip со всеми вложенными
if "%1"=="sng" (
  for /r %PathSrc%\CompSrc %%i in (.) do @echo /i:"%%~fi"; >> %FileCfg%
)
rem Репозитарий Галактики со всеми вложенными
if "%1"=="tmp" (
  for /r %RepoGal%\CompSrc %%i in (.) do @echo /i:"%%~fi"; >> %FileCfg%
)
rem Пути к ресурсам
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
echo Время формирования: %bTime% - %eTime%
echo ===============================================================================
