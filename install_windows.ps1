# install_windows.ps1
# SPYderScalp - Windows PowerShell Installer (Alternative)
# - Installs Python (via winget) if missing
# - Creates venv .venv
# - Installs dependencies from requirements.txt
# - Creates a helper run script
#
# Note: SPYderScalp.bat handles all of this automatically.
#       Use this script only if you prefer PowerShell or need
#       winget-based Python installation.

$ErrorActionPreference = "Stop"

function Write-Info($msg) { Write-Host "[*] $msg" -ForegroundColor Cyan }
function Write-Ok($msg)   { Write-Host "[+] $msg" -ForegroundColor Green }
function Write-Warn($msg) { Write-Host "[!] $msg" -ForegroundColor Yellow }

# --- Validate we are in the right folder ---
$appFile = Join-Path $PSScriptRoot "spyer.py"
if (-not (Test-Path $appFile)) {
    throw "spyer.py not found in $PSScriptRoot. Put install_windows.ps1 next to the .py file and re-run."
}

# --- Ensure winget exists (usually present on Win11) ---
$winget = Get-Command winget -ErrorAction SilentlyContinue
if (-not $winget) {
    Write-Warn "winget not found. Install 'App Installer' from Microsoft Store, or install Python manually from python.org."
    throw "Cannot continue without winget or a preinstalled Python."
}

# --- Ensure Python is installed ---
$pythonCmd = Get-Command python -ErrorAction SilentlyContinue
if (-not $pythonCmd) {
    Write-Info "Python not found. Installing Python 3.x via winget..."
    winget install --id Python.Python.3 --source winget --accept-package-agreements --accept-source-agreements
    Write-Ok "Python install attempted. Re-checking python..."
    $pythonCmd = Get-Command python -ErrorAction SilentlyContinue
    if (-not $pythonCmd) {
        throw "Python still not found after install. Restart PowerShell and try again, or verify Python is on PATH."
    }
} else {
    Write-Ok "Python found: $($pythonCmd.Source)"
}

# --- Check Python version >= 3.9 ---
$pyVersion = python --version 2>&1
if ($pyVersion -match '(\d+)\.(\d+)') {
    $major = [int]$Matches[1]
    $minor = [int]$Matches[2]
    if ($major -lt 3 -or ($major -eq 3 -and $minor -lt 9)) {
        throw "Python 3.9+ required but found $pyVersion. Please install a newer version."
    }
    Write-Ok "Python version OK: $pyVersion"
}

# --- Upgrade pip tooling ---
Write-Info "Upgrading pip/setuptools/wheel..."
python -m pip install --upgrade pip setuptools wheel

# --- Create venv ---
$venvPath = Join-Path $PSScriptRoot ".venv"
if (-not (Test-Path $venvPath)) {
    Write-Info "Creating virtual environment at .venv ..."
    python -m venv $venvPath
    Write-Ok "Created .venv"
} else {
    Write-Ok ".venv already exists"
}

# --- Activate venv for this script run ---
$activate = Join-Path $venvPath "Scripts\Activate.ps1"
if (-not (Test-Path $activate)) {
    throw "Could not find venv activation script at $activate"
}

Write-Info "Activating venv..."
. $activate

# --- Install dependencies from requirements.txt ---
$reqPath = Join-Path $PSScriptRoot "requirements.txt"
if (Test-Path $reqPath) {
    Write-Info "Installing Python dependencies from requirements.txt..."
    pip install --upgrade -r $reqPath
} else {
    Write-Info "Installing Python dependencies..."
    pip install --upgrade yfinance pandas numpy PyQt5 matplotlib plyer pytz
}

Write-Ok "Dependencies installed."

# --- Create a run helper script ---
$runScript = Join-Path $PSScriptRoot "run_app.ps1"
@"
`$ErrorActionPreference = "Stop"
. "`$PSScriptRoot\.venv\Scripts\Activate.ps1"
python "`$PSScriptRoot\spyer.py"
"@ | Out-File -Encoding UTF8 $runScript

Write-Ok "Created run helper: run_app.ps1"

Write-Host ""
Write-Ok "Done."
Write-Host "Next: Right-click run_app.ps1 -> 'Run with PowerShell' (or run: .\run_app.ps1)"
Write-Host "      Or just double-click SPYderScalp.bat to launch."
