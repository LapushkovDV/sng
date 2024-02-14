@echo off
rem ********************************************************************************
rem Создание конфигурационного файла для сборки компонента
rem ********************************************************************************
call SetPath.cmd
@echo on

rem set RepoGal=D:\Gal\SNG\Source\update-10600
rem set PathSrc=D:\Gal\SNG\Source\update-10600-src
rem Удалить все файлы
if not exist %PathSrc% md %PathSrc%
del /f /s /q %PathSrc%\*.* > nul
rem Скопировать кроме vip
xcopy %RepoGal%\*.* %PathSrc% /e /q /exclude:ExcludeVip.list
