# SPYderScalp v5.0

<p align="center">
  <img src="sf.jpg" width="200" alt="SPYderScalp">
</p>

**Built by: SkyzFallin**

**Real-time SPY intraday options signal monitor with multi-indicator quality scoring, multi-timeframe confirmation, prediction tracking, options value scanner, DTE recommendations, economic calendar awareness, and hold-time estimates.**

SPYderScalp watches SPY price action and alerts you when conditions line up for a potential 0-2 DTE options trade -- then tells you *how good* the signal is with a quality score from 0-100 and a letter grade (A+ to F), explains *why* it gave that rating in plain English, recommends *which DTE to trade* based on time of day and conditions, tells you *how long to hold* based on momentum and upcoming economic events, tracks *prediction accuracy* over time, and can scan the options chain for *mispriced contracts*.

![Python 3.9+](https://img.shields.io/badge/python-3.9%2B-blue)
![License: MIT](https://img.shields.io/badge/license-MIT-green)
![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Windows%20%7C%20Linux-lightgrey)

---

## Features

- **Side-by-side layout** -- chart on the left, signals on the right, optimized for 1366x768+ displays
- **Live candlestick chart** with VWAP, EMA 9/21, Bollinger Bands, VWAP bands, RSI subplot, and MACD subplot
- **Multi-timeframe chart** -- switch between 1m, 5m, 15m, 1h, and 1d views
- **Auto support/resistance levels** -- detected from price action, drawn on the chart
- **Manual price lines** -- add custom levels to the chart at any price
- **Signal quality scoring** (0-100) across 12 weighted indicators
- **Multi-timeframe confirmation** -- cross-references 1m signals against 5m and 15m trends for higher confidence
- **RSI divergence detection** -- spots bullish/bearish divergences for early reversal signals
- **Bollinger Band squeeze detection** -- identifies low-volatility compression before breakouts
- **Candle pattern recognition** -- detects engulfing, hammer, doji, and other patterns
- **Plain-English explanations** -- every signal tells you exactly why it got that grade
- **DTE recommender** -- suggests 0, 1, or 2 DTE based on time of day, signal strength, volume, RSI, and event proximity
- **Hold-time recommendations** -- how long to hold based on DTE, momentum, events, and time of day
- **Prediction tracking** -- logs every signal, checks the outcome, and rates accuracy over time with CSV export
- **Open/Close swing forecast** -- predicts today's direction using 3 months of historical daily data
- **Options value scanner** -- separate window that scans for mispriced contracts, IV discounts, intrinsic edges, and unusual activity
- **Economic calendar** -- built-in calendar of CPI, FOMC, NFP, PPI, GDP, Retail Sales, and Jobless Claims for 2025-2026 with countdown timers
- **Event-aware scoring** -- signals near major releases get automatically downgraded
- **Intraday volatility zones** -- warns during market open surge, lunch lull, power hour
- **Eastern Time aware** -- all market logic uses ET regardless of your local timezone
- **Market hours auto-stop** -- monitoring pauses automatically at market close, resumes at open
- **Tabbed interface** -- Signal breakdown, Hold reasons, History, Calendar, and Log in separate tabs
- **Status indicator** -- live dot shows monitoring/stopped/scanning state
- Recommended 0-2 DTE option strikes
- Desktop notifications + sound alerts
- Configurable volume threshold and minimum grade filter
- Works on **Windows, macOS, and Linux**

---

## Signal Quality Scoring

Every signal is evaluated across 12 indicators, each weighted for a total score of 0-100:

| Indicator | Weight | What It Measures |
|-----------|--------|-----------------|
| **VWAP Distance** | 15 | How far price has broken past VWAP |
| **Volume Surge** | 14 | Current volume vs 20-bar average |
| **EMA Trend** | 13 | EMA-9 / EMA-21 alignment with signal direction |
| **Event Timing** | 12 | Penalty when major economic release is imminent |
| **RSI Momentum** | 8 | RSI in the sweet spot (not overbought/oversold) |
| **MACD Confirmation** | 7 | MACD line/signal crossover and histogram direction |
| **Candle Momentum** | 6 | Consecutive bars moving in signal direction |
| **RSI Divergence** | 6 | Bullish/bearish divergence between price and RSI |
| **Bollinger Squeeze** | 5 | Low-volatility compression signaling breakout |
| **Candle Patterns** | 5 | Engulfing, hammer, doji, and other reversal/continuation patterns |
| **Range Position** | 5 | Where price sits within today's high/low range |
| **Trend Alignment** | 4 | Higher-timeframe trend consistency |

Signals are then cross-referenced against 5-minute and 15-minute timeframes for **multi-timeframe confirmation**. When all timeframes agree, the signal score gets a boost; conflicting timeframes reduce confidence.

### Grade Scale

| Grade | Score | Meaning |
|-------|-------|---------|
| A+ | 85-100 | Strong conviction -- all indicators aligned |
| A | 75-84 | High quality signal |
| B | 65-74 | Solid setup, minor concerns |
| C | 50-64 | Marginal -- proceed with caution |
| D | 35-49 | Weak signal, most indicators not confirming |
| F | 0-34 | Noise -- skip it |

### Example Signal Explanation

```
WHY THIS GRADE:
  Strong bullish setup. Multiple indicators aligned,
  giving high confidence in the trade.

  [OK] VWAP: Price $0.87 above VWAP - clear break,
       bullish institutional flow confirmed.
  [OK] Volume: 2.3x avg - strong participation,
       real buying/selling pressure behind this move.
  [~] RSI: 67 - healthy bullish momentum but approaching overbought.
  [X] Trend: EMAs weakly aligned. The trend is present but not strong.
  [OK] MACD: Bullish crossover confirmed with rising histogram.
  [OK] RSI divergence: Bullish divergence detected (75%).
  [OK] No imminent economic events - clear window to trade.
```

---

## Prediction Tracking

Every signal is automatically logged in the **History** tab with:
- Signal type, grade, score, and price at signal time
- Outcome check after hold period expires
- Win/loss determination with P&L percentage
- Running accuracy stats (win rate, average return)
- **CSV export** for offline analysis

The tracker summary shows your session stats in the top status bar.

---

## Open/Close Swing Forecast

On startup, SPYderScalp fetches 3 months of daily SPY data and predicts today's direction based on:
- Day-of-week historical bias (e.g. "Tuesdays tend up: avg +0.12%")
- Last 5 days momentum
- 20-day trend direction
- Mean reversion after big moves

The forecast shows below the signal area with a direction and confidence percentage.

---

## DTE Recommender

SPYderScalp tells you whether to trade 0, 1, or 2 DTE options based on current conditions:

| Factor | 0DTE Preferred | 1DTE Preferred | 2DTE Preferred |
|--------|---------------|----------------|----------------|
| **Time of day** | Before ~1 PM ET | After 1 PM ET | Late power hour |
| **Signal grade** | A+ / A (high conviction) | B / C (needs room) | D / F (weak, needs time) |
| **Volume** | High (2x+ avg) | Normal | Low (weak follow-through) |
| **RSI** | Normal range | Any | Extreme (reversal risk) |
| **Events** | No events near | Event in 30-60 min | Major event imminent |
| **Day of week** | Mon-Thu morning | Friday afternoon | -- |

The recommendation shows as `Rec: 0DTE` with a score comparison like `0DTE:85 | 1DTE:60 | 2DTE:30` so you can see how close the call was.

---

## Options Value Scanner

Click **Value Scanner** (purple button) to open a separate window that scans SPY option chains for opportunities:

- **Intrinsic edge** -- midpoint priced below intrinsic value
- **Model discount** -- ask price below Black-Scholes theoretical fair value
- **IV discount** -- implied volatility lower than neighboring strikes
- **Spread value** -- wide bid-ask where last trade filled well below midpoint
- **Volume spike** -- unusual volume relative to open interest
- **Liquidity value** -- tight spread + high volume = easy fills
- **Penny contracts** -- near-the-money OTM contracts at $0.01-0.05

Each opportunity gets a composite score. Click any row for a detailed breakdown with a limit order suggestion.

---

## Hold-Time Recommendations

Every signal includes a suggested hold duration and exit time (in Eastern Time):

| Factor | Effect |
|--------|--------|
| **DTE** | 0DTE: ~15 min scalp, 1DTE: ~30 min, 2DTE: ~45 min |
| **Signal strength** | A+ extends hold time, C/D shortens it |
| **Volume** | Very high volume = move may exhaust quickly |
| **RSI extremes** | Overbought calls / oversold puts = reversal risk |
| **Event proximity** | Exits before upcoming CPI/FOMC/NFP releases |
| **Time of day** | Caps hold time near market close (ET) |

```
HOLD: ~22 min  |  Exit by 10:47 AM ET  |  Confidence: HIGH
    * 1DTE -> base 30 min hold
    * A signal -> extended to 39 min
    * [!] CPI Report in 35 min -> exit before event (hold 22 min)
```

---

## Chart Features

The live candlestick chart includes:
- **Candlesticks** with green/red bodies and wicks
- **VWAP line** (gold) with optional VWAP standard deviation bands
- **EMA 9** (blue) and **EMA 21** (purple) overlays
- **Bollinger Bands** (toggleable)
- **Auto support/resistance levels** from price clustering (toggleable)
- **Manual price lines** -- type any price and add it to the chart
- **RSI subplot** with overbought/oversold zones
- **MACD subplot** with signal line and histogram
- **Volume bars** in the background
- **Multi-timeframe switching** -- 1m, 5m, 15m, 1h, 1d chart views

---

## Economic Calendar

Built-in calendar of every major US economic event for 2025-2026:

- **FOMC Decisions** -- all 8 meetings per year
- **CPI / PPI Reports** -- monthly releases
- **Non-Farm Payrolls (NFP)** -- monthly jobs reports
- **GDP Reports** -- quarterly (advance, second estimate, final)
- **Retail Sales** -- monthly consumer spending data
- **Initial Jobless Claims** -- every Thursday at 8:30 AM ET

The Calendar tab shows today's events with countdown timers and the next 14 days of upcoming releases.

---

## Quick Start

### Prerequisites

- Python 3.9 or higher
- Internet connection (Yahoo Finance data)

### Install

```bash
git clone https://github.com/YOUR_USERNAME/SPYderScalp.git
cd SPYderScalp
pip install -r requirements.txt
```

### Run

```bash
python spyer.py
```

### Windows One-Click Setup

Just double-click **`SPYderScalp.bat`** -- it handles everything:
- First run: finds Python, creates venv, installs deps, launches (~1 min)
- After that: launches in seconds
- Fully portable -- move the folder anywhere

### macOS One-Click Setup

Double-click **`SPYderScalp.command`** -- same idea as the Windows launcher:
- First run: finds Python 3.9+, creates venv, installs deps, launches (~1 min)
- After that: launches in seconds and closes the Terminal window automatically

> **Note:** On first run macOS may ask you to allow the script. Right-click -> Open if double-click is blocked by Gatekeeper.

Or manually:

```bash
git clone https://github.com/YOUR_USERNAME/SPYderScalp.git
cd SPYderScalp
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python spyer.py
```

macOS uses the built-in `afplay` command for sound alerts (Glass.aiff). Timezone handling uses `zoneinfo` which is included in Python 3.9+ -- no extra dependencies needed beyond what's in requirements.txt.

---

## Usage

1. Launch the app
2. Monitoring starts automatically during market hours (9:30 AM - 4:00 PM ET)
3. Or click **Scan Now** for an immediate check anytime
4. When a signal fires you'll see:
   - Signal type (CALL / PUT) with quality score and letter grade
   - Multi-timeframe confirmation status
   - DTE recommendation (0, 1, or 2 DTE with reasoning)
   - Plain-English explanation of the rating
   - Candlestick chart with RSI, MACD, S/R levels
   - Hold-time recommendation with exit time in ET
   - Recommended option strikes
5. Click **Value Scanner** to find mispriced options contracts
6. Use tabs on the right panel: Signal, Hold, History, Calendar, Log

### Top Bar Settings

- **Calls / Puts** -- toggle which directions you want alerts for
- **Min** -- minimum grade to trigger alerts (default: C)
- **Vol** -- volume ratio required to trigger (default: 150% = 1.5x average)

### Chart Controls

- **S/R** checkbox -- toggle auto-detected support/resistance levels
- **BB** checkbox -- toggle Bollinger Bands overlay
- **VWAP±** checkbox -- toggle VWAP standard deviation bands
- **Add Line** -- add a manual price line at any level
- **Timeframe buttons** -- switch chart between 1m, 5m, 15m, 1h, 1d

---

## Timezone Handling

All market-sensitive logic runs in **US Eastern Time** regardless of your local timezone. Uses `zoneinfo` (Python 3.9+) with `pytz` fallback. Hold time exit times, market close caps, event countdowns, and intraday zones all reference ET market hours. Monitoring auto-stops at market close and resumes at open.

---

## Project Structure

```
SPYderScalp/
  spyer.py                  # Main app (signals, chart, calendar, scanner, UI)
  sf.jpg                    # App logo
  SPYderScalp.bat           # Windows smart launcher (double-click to run)
  SPYderScalp.command        # macOS smart launcher (double-click to run)
  install_windows.ps1       # Windows PowerShell installer (alternative)
  requirements.txt          # Python dependencies
  LICENSE                   # MIT license
  README.md                 # This file
```

---

## Roadmap

- [x] Multi-indicator signal scoring (12 weighted indicators)
- [x] Multi-timeframe confirmation (5m + 15m cross-reference)
- [x] Candlestick chart with RSI & MACD
- [x] Multi-timeframe chart views (1m, 5m, 15m, 1h, 1d)
- [x] Auto support/resistance levels
- [x] Bollinger Bands & VWAP bands overlays
- [x] RSI divergence detection
- [x] Bollinger Band squeeze detection
- [x] Candle pattern recognition
- [x] Economic calendar (2025-2026)
- [x] Hold-time recommendations
- [x] Plain-English signal explanations
- [x] Side-by-side layout for laptops
- [x] Eastern Time awareness + market hours auto-stop
- [x] DTE recommender (0/1/2 DTE)
- [x] Options value scanner (mispriced contracts)
- [x] Prediction tracking with accuracy stats
- [x] Open/Close swing forecast
- [x] CSV export of prediction history
- [ ] Real-time data source integration
- [ ] Auto-trade via broker API (Tradier, IBKR)

---

## Disclaimer

This app provides **alerts only**, not financial advice. Always verify signals before trading. 0DTE options are extremely risky -- use proper position sizing and risk management.

---

## License

MIT -- see [LICENSE](LICENSE).
