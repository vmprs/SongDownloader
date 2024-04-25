@echo off
setlocal enabledelayedexpansion
title Automate Git
set /a count=0

:commit_loop
cls
color 0a
set commit_message=Hi%random%
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
