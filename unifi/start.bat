@echo off
:: Launches the UniFi set-inform PowerShell script with correct flags
:: Place this .bat in the same folder as unifi-set-inform.ps1 and plink.exe

powershell.exe -NoExit -ExecutionPolicy Bypass -File "%~dp0unifi-set-inform.ps1"
