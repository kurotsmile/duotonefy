@echo off
setlocal EnableExtensions

set "PROJECT_ROOT=%~dp0"
set "ACCOUNT=dangthivan79@gmail.com"
set "PROJECT=duotonefy"

cd /d "%PROJECT_ROOT%"

echo Checking Firebase login for %ACCOUNT%...
firebase login:list 2>nul | findstr /I /C:"%ACCOUNT%" >nul
if errorlevel 1 (
    echo Desired account not present or a different account is logged in.
    echo Logging out of current Firebase session...
    firebase logout >nul 2>&1

    echo Logging in as %ACCOUNT%...
    firebase login --no-localhost
    if errorlevel 1 (
        echo Login failed.
        exit /b 1
    )
)

echo Deploying Firebase Hosting...
firebase --account "%ACCOUNT%" deploy --only hosting --project "%PROJECT%"
if errorlevel 1 (
    echo Deploy failed.
    exit /b 1
)

echo Deploy completed successfully.
exit /b 0
