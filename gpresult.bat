@echo off
cls

echo !!! PLEASE RUN AS ADMINISTRATOR !!!
echo:
echo:
echo:
echo:

echo Enter the name or IPv4 address of the remote computer:
set /p mado="Computer: "

echo Enter the username for the remote computer:
set /p homu="Username: "

gpresult /S %mado% /user %homu% /R

pause
