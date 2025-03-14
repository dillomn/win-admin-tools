@echo off
set "folder=C:\Users\%username%\AppData\Roaming\TeamworkChat\Cache"

pushd "%folder%"
for %%F in (*) do (
    if /i not "%%F"=="index" (
        del "%%F"
    )
)
popd