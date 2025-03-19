@echo off
set "folder=C:\Users\%username%\AppData\Roaming\TeamworkChat\Cache"
set "TeamworkChat=C:\Users\%username%\AppData\Local\TeamworkChat\TeamworkChat.exe"

:: Kill's Teamwork Chat process so that the cache can be deleted.
taskkill /IM TeamworkChat.exe /F

:: Wait for TeamworkChat to stop before clearing the cache
timeout /t 2 /nobreak >nul

pushd "%folder%"
for %%F in (*) do (
    if /i not "%%F"=="index" (
        del "%%F"
    )
)
popd

:: Wait for TeamworkChat cache to be cleared
timeout /t 2 /nobreak >nul

:: Re-open TeamworkChat
start "" "%TeamworkChat%"
