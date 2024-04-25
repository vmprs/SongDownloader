@echo off
setlocal enabledelayedexpansion

set /a count=0
set /p commit_message="Enter your commit message: "

:commit_loop
if %count% lss 100 (
    REM Add all files to the staging area
    git add .

    REM Commit changes with the provided message
    git commit -m "%commit_message%"

    REM Push changes to GitHub (assuming the branch is 'main')
    git push origin main

    set /a count+=1
    goto commit_loop
)

echo Done
