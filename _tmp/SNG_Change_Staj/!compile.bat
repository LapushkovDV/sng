rem �� ���-�����-���� YYYYMMDD ��� WINXP
@set DD=%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%

del *.res
del *.tmp
del *.crf
del *.tmp
del *.dsk
del *.fnc
del *.log
del Atlantis*.res

@set exedir=C:\Galaktika\ATL6\Update_11400\support\exe

@%exedir%\vip.exe SNG_Change_Staj.prj /r:SNG_Change_Staj.res /c:vip.cfg /u:lapus /p:Zraeqw123 /def:Atl60

rem /c:support_res.cfg
@echo ��������� �����襭�
@goto END

:END

pause
@exit

