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

:: --- Need to create venv. Find system Python 3.9+ first. ---
echo [*] No virtual environment found. Setting up...

set "SYSPY="
for %%P in (python python3) do (
    if not defined SYSPY (
        where %%P >nul 2>&1
        if !errorlevel! equ 0 (
            for /f "tokens=2 delims= " %%V in ('%%P --version 2^>^&1') do (
                for /f "tokens=1,2 delims=." %%A in ("%%V") do (
                    if %%A GEQ 3 if %%B GEQ 9 (
                        set "SYSPY=%%P"
                    )
                )
            )
        )
    )
)

if not defined SYSPY (
    echo.
    echo [ERROR] Python 3.9 or higher is required but was not found.
    echo.
    echo   1. Go to https://www.python.org/downloads/
    echo   2. Download Python 3.9 or higher
    echo   3. Check "Add Python to PATH" during install
    echo   4. Double-click SPYderScalp.bat again
    echo.
    pause
    exit /b 1
)

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
%PY% -c "import PyQt5; import yfinance; import matplotlib; import plyer; import pytz; import pandas; import numpy" >nul 2>&1
if !errorlevel! equ 0 goto :deps_ok

echo [*] Installing dependencies. This takes about a minute...
%PIP% install --upgrade pip >nul 2>&1

:: Use requirements.txt if available, otherwise fall back to package list
if exist "requirements.txt" (
    %PIP% install --no-cache-dir -r requirements.txt
) else (
    %PIP% install --no-cache-dir yfinance pandas numpy PyQt5 matplotlib plyer pytz
)

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
