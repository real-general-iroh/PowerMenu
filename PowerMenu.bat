@echo off

:: *** WARNING: Modifying the registry can harm your system. Proceed with caution! ***
:: *** It's strongly recommended to create a registry backup before continuing. ***

:: Check for Administrator privileges
net session >nul 2>&1
if %errorlevel% == 0 (
    goto :gotAdmin
) else (
    echo.
    echo ERROR: This script requires Administrator permissions.
    echo Please right-click on the script file and select "Run as administrator".
    pause
    exit /b 1 
)

:gotAdmin

:: Modify the registry
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve /t REG_SZ /d ""

:: Notify of changes and prompt for restart
echo.
echo Registry modification successful.
echo.
echo Windows Explorer needs to restart or a FULL restart is required.
echo Would you like to restart Windows Explorer and avoid a full restart? [Y/n]
choice /c YN /n >nul

if %errorlevel% == 2 (
   echo You chose not to restart Windows Explorer. Changes may not take effect until restart.
) else (
   taskkill /f /im explorer.exe
   start explorer.exe
)

echo.
echo Script complete.
pause
