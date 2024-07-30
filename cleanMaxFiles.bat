@echo off
REM Script to take ownership and delete folders
setlocal enabledelayedexpansion

REM Define folders to clear
set folders=C:\ChaosPhoenix
set folders=!folders! C:\ESD
set folders=!folders! C:\Program Files\Autodesk
set folders=!folders! C:\Program Files\AXYZ design
set folders=!folders! C:\Program Files\Common Files\Autodesk
set folders=!folders! C:\Program Files\Common Files\Autodesk Shared
set folders=!folders! C:\Program Files (x86)\Common Files\Autodesk Shared
set folders=!folders! C:\Program Files\Chaos Group\V-Ray\3ds Max 2020
set folders=!folders! C:\Program Files (x86)\Autodesk
set folders=!folders! C:\PhoenixFD
set folders=!folders! C:\ProgramData\Autodesk
set folders=!folders! C:\ProgramData\tyFlow
set folders=!folders! C:\ProgramData\Itoo Software

REM Loop through folders, take ownership and delete
for %%F in (!folders!) do (
    echo Clearing folder %%F
    if exist "%%F" (
        takeown /f "%%F" /r /d y
        icacls "%%F" /grant administrators:F /T
        echo Took ownership of Folder %%F
        rmdir /S /Q "%%F"
        echo Folder %%F has been cleared.
    ) else (
        echo Folder %%F does not exist.
    )
)

echo All specified folders have been removed.
pause
