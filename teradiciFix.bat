@echo off
REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "NoDispCPL" /t REG_DWORD /d 0 /f
exit /b