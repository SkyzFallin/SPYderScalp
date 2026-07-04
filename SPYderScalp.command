#!/bin/bash
# ============================================================
#  SPYderScalp.command - macOS Smart Launcher
#  Double-click to run. Handles venv and deps automatically.
# ============================================================

set -e

# cd to the folder this script lives in (works with double-click)
cd "$(dirname "$0")"

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

info()  { echo -e "${CYAN}[*]${NC} $1"; }
ok()    { echo -e "${GREEN}[+]${NC} $1"; }
warn()  { echo -e "${YELLOW}[!]${NC} $1"; }
fail()  { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

# --- Verify spyer.py exists ---
if [ ! -f "spyer.py" ]; then
    fail "spyer.py not found in this folder. Put SPYderScalp.command next to spyer.py."
fi

# --- Find Python 3.9+ ---
find_python() {
    for cmd in python3 python; do
        if command -v "$cmd" &>/dev/null; then
            version=$("$cmd" --version 2>&1 | grep -oE '[0-9]+\.[0-9]+')
            major=$(echo "$version" | cut -d. -f1)
            minor=$(echo "$version" | cut -d. -f2)
            if [ "$major" -ge 3 ] && [ "$minor" -ge 9 ]; then
                echo "$cmd"
                return 0
            fi
        fi
    done
    return 1
}

SYSPY=$(find_python) || {
    echo ""
    fail "Python 3.9+ not found.

    Install it with one of:
      brew install python@3.12
      -- or --
      Download from https://www.python.org/downloads/

    Then double-click SPYderScalp.command again."
}

ok "Found: $SYSPY ($($SYSPY --version))"

# --- Check for existing venv ---
if [ -f ".venv/bin/python" ]; then
    ok "Virtual environment exists"
else
    info "Creating virtual environment..."
    "$SYSPY" -m venv .venv || fail "Failed to create virtual environment."
    ok "venv created"
fi

PY=".venv/bin/python"
PIP=".venv/bin/pip"

# --- Check if deps are installed ---
if "$PY" -c "import PyQt5; import yfinance; import matplotlib; import plyer; import pytz; import pandas; import numpy" 2>/dev/null; then
    ok "Dependencies OK"
else
    info "Installing dependencies (this takes about a minute)..."
    "$PIP" install --upgrade pip >/dev/null 2>&1

    # Use requirements.txt if available, otherwise fall back to package list
    if [ -f "requirements.txt" ]; then
        "$PIP" install --no-cache-dir -r requirements.txt || {
            fail "Package install failed. Check your internet connection."
        }
    else
        "$PIP" install --no-cache-dir yfinance pandas numpy PyQt5 matplotlib plyer pytz || {
            fail "Package install failed. Check your internet connection."
        }
    fi
    ok "Dependencies installed"
fi

# --- Launch the app ---
ok "Launching SPYderScalp..."
echo ""

# Run in background; log stderr to crash.log for debugging
LOGFILE="$(pwd)/crash.log"
nohup "$PY" "$(pwd)/spyer.py" >/dev/null 2>>"$LOGFILE" &

# Give the app a moment to start, then close Terminal
sleep 1

# Close this Terminal window via AppleScript
osascript -e 'tell application "Terminal"
    close front window
end tell' 2>/dev/null || true
