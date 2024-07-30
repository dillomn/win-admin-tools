@echo off
set "registryKey=HKEY_LOCAL_MACHINE\SOFTWARE\Khronos\OpenXR\1"
set "valueName=ActiveRuntime"
set "valueData=C:\Program Files\Oculus\Support\oculus-runtime\oculus_openxr_64.json"

echo Updating the registry...
reg.exe add "%registryKey%" /v "%valueName%" /t REG_SZ /d "%valueData%" /f

if %errorlevel% equ 0 (
    echo Registry value "%valueName%" updated successfully.
) else (
    echo An error occurred while updating the registry.
)

pause
