@echo off
setlocal enabledelayedexpansion

:: ============================================================
::  SPYderScalp.bat - Smart Launcher
::  Double-click to run. Handles venv and deps automatically.
:: ============================================================

title SPYderScalp
cd /d "%~dp0"

if not exist "spyer.py" (
    echo [ERROR] spyer.py not found in this folder.
    pause
    exit /b 1
)

:: --- Check for existing venv ---
if exist ".venv\Scripts\python.exe" goto :venv_ready

:: --- Need to create venv. Find system Python first. ---
echo [*] No virtual environment found. Setting up...

where python >nul 2>&1
if !errorlevel! equ 0 (
    set "SYSPY=python"
    goto :found_system_python
)

where python3 >nul 2>&1
if !errorlevel! equ 0 (
    set "SYSPY=python3"
    goto :found_system_python
)

:: --- No Python at all ---
echo.
echo [ERROR] Python is not installed.
echo.
echo   1. Go to https://www.python.org/downloads/
echo   2. Download Python 3.9 or higher
echo   3. Check "Add Python to PATH" during install
echo   4. Double-click SPYderScalp.bat again
echo.
pause
exit /b 1

:found_system_python
echo [+] Found: %SYSPY%
echo [*] Creating virtual environment...
%SYSPY% -m venv .venv
if !errorlevel! neq 0 (
    echo [ERROR] Failed to create virtual environment.
    pause
    exit /b 1
)
echo [+] venv created

:venv_ready
set "PY=.venv\Scripts\python.exe"
set "PIP=.venv\Scripts\pip.exe"

:: --- Check if deps are installed ---
%PY% -c "import PyQt5; import yfinance; import matplotlib; import plyer; import pytz" >nul 2>&1
if !errorlevel! equ 0 goto :deps_ok

echo [*] Installing dependencies. This takes about a minute...
%PIP% install --upgrade pip >nul 2>&1
%PIP% install --no-cache-dir yfinance pandas numpy PyQt5 matplotlib plyer pytz
if !errorlevel! neq 0 (
    echo.
    echo [ERROR] Package install failed. Check your internet connection.
    pause
    exit /b 1
)
echo [+] Dependencies installed

:deps_ok
:: --- Launch the app and close this window ---
set "PYW=.venv\Scripts\pythonw.exe"
if exist "%PYW%" (
    start "" "%PYW%" "%~dp0spyer.py"
) else (
    start "" "%PY%" "%~dp0spyer.py"
)
exit /b 0
