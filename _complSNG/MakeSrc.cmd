@echo off
rem ********************************************************************************
rem �������� ���䨣��樮����� 䠩�� ��� ᡮન ���������
rem ********************************************************************************
call SetPath.cmd
@echo on

rem set RepoGal=D:\Gal\SNG\Source\update-10600
rem set PathSrc=D:\Gal\SNG\Source\update-10600-src
rem ������� �� 䠩��
if not exist %PathSrc% md %PathSrc%
del /f /s /q %PathSrc%\*.* > nul
rem �����஢��� �஬� vip
xcopy %RepoGal%\*.* %PathSrc% /e /q /exclude:ExcludeVip.list
