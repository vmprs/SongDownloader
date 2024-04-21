@echo off

rem Get the current directory path
set "current_dir=%~dp0"

rem Set the path to the PowerShell script in the current directory
set "ps_script=%current_dir%e2dl.ps1"

rem Check if the PowerShell script exists
if not exist "%ps_script%" (
    echo Error: PowerShell script not found at "%ps_script%"
    pause
    exit /b 1
)

rem Run the PowerShell script
powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "%ps_script%"
