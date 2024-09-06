@echo off
setlocal enabledelayedexpansion

:: Get the folder where the script is located
set "folder=%~dp0"

:: Output file for the old and new names
set "logFile=rename_log.txt"

:: Output file for the revert script
set "revertScript=revert_rename.bat"

:: Full paths for log and revert files
set "logFilePath=%folder%%logFile%"
set "revertScriptPath=%folder%%revertScript%"

:: Empty or create the log file and revert script
echo OldName,NewName > "%logFilePath%"
echo @echo off > "%revertScriptPath%"

:: Loop through all files in the folder
for %%F in ("%folder%*") do (
    if not "%%~nxF"=="%~nx0" if not "%%~nxF"=="%logFile%" if not "%%~nxF"=="%revertScript%" (
        set "oldName=%%~nxF"
        set "fileExt=%%~xF"
        
        :: Generate a random name (8 characters)
        set "newName="
        for /l %%N in (1,1,8) do set "newName=!newName!!random:~0,1!"
        set "newName=!newName!!fileExt!"

        :: Ensure new name is unique
        set "newFilePath=%folder%!newName!"
        if exist "!newFilePath!" (
            echo Error: File with new name !newName! already exists. Exiting.
            exit /b 1
        )
        
        :: Rename the file
        ren "%%F" "!newName!"
        
        :: Log the rename action
        echo !oldName!,!newName! >> "%logFilePath%"
        
        :: Add to revert script
        echo ren "!newName!" "%%~nxF" >> "%revertScriptPath%"
    )
)

echo Renaming completed. Log file: %logFilePath%
echo Revert script created: %revertScriptPath%
endlocal
