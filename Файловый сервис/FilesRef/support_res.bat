@rem �� ���-�����-���� YYYYMMDD ��� WINXP
@set DD=%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%
del *.crf
del *.tmp
del tmp\*.* /f /s /q
del OUT\*.* /f /s /q
del *.dsk
del *.fnc
del *.log
del *.res
del Atlantis*.res

rem ��� ������ �� ��������� 6.x-������
set ExtraDefine=if "%AtlVer:~0,1%"=="6" set ExtraDefine=/def:Atl60

@set exedir=D:\Galaktika\GAL91\sng-alt\support

@%exedir%\vip64x.EXE FilesRef.prj /r:FilesRef.res

del *.tmp
del *.crf
del *.dsk
del *.fnc
del *.log
del Atlantis*.res
del tmp\*.* /f /s /q
del OUT\*.* /f /s /q


rem /c:support_res.cfg
@echo ��������� �����襭�
@goto END

:END

@pause
@exit
