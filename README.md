# SPYderScalp v4.20.69

<p align="center">
  <img src="sf.jpg" width="200" alt="SPYderScalp">
</p>

**Built by: SkyzFallin**

**Real-time SPY intraday options signal monitor with multi-indicator quality scoring, options value scanner, DTE recommendations, economic calendar awareness, and hold-time estimates.**

SPYderScalp watches SPY price action and alerts you when conditions line up for a potential 0-2 DTE options trade -- then tells you *how good* the signal is with a quality score from 0-100 and a letter grade (A+ to F), explains *why* it gave that rating in plain English, recommends *which DTE to trade* based on time of day and conditions, tells you *how long to hold* based on momentum and upcoming economic events, and can scan the options chain for *mispriced contracts*.

![Python 3.9+](https://img.shields.io/badge/python-3.9%2B-blue)
![License: MIT](https://img.shields.io/badge/license-MIT-green)
![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Windows%20%7C%20Linux-lightgrey)

---

## Features

- **Side-by-side layout** -- chart on the left, signals on the right, optimized for 1366x768 laptops
- **Live candlestick chart** with VWAP, EMA 9/21 overlays, RSI subplot, and MACD subplot
- **Signal quality scoring** (0-100) across 7 weighted indicators
- **Plain-English explanations** -- every signal tells you exactly why it got that grade
- **DTE recommender** -- suggests 0, 1, or 2 DTE based on time of day, signal strength, volume, RSI, and event proximity
- **Hold-time recommendations** -- how long to hold based on DTE, momentum, events, and time of day
- **Options value scanner** -- separate window that scans for mispriced contracts, IV discounts, intrinsic edges, and unusual activity
- **Economic calendar** -- built-in calendar of CPI, FOMC, NFP, PPI, GDP, Retail Sales, and Jobless Claims for 2025-2026 with countdown timers
- **Event-aware scoring** -- signals near major releases get automatically downgraded
- **Intraday volatility zones** -- warns during market open surge, lunch lull, power hour
- **Eastern Time aware** -- all market logic uses ET regardless of your local timezone
- **Tabbed interface** -- Signal breakdown, Hold reasons, Calendar, and Log in separate tabs
- Recommended 0-2 DTE option strikes
- Desktop notifications + sound alerts
- Configurable volume threshold and minimum grade filter
- Works on **Windows, macOS, and Linux**

---

## Signal Quality Scoring

Every signal is evaluated across 7 indicators, each weighted for a total score of 0-100:

| Indicator | Weight | What It Measures |
|-----------|--------|-----------------|
| **VWAP Distance** | 20 | How far price has broken past VWAP |
| **Volume Surge** | 18 | Current volume vs 20-bar average |
| **EMA Trend** | 18 | EMA-9 / EMA-21 alignment with signal direction |
| **Event Timing** | 16 | Penalty when major economic release is imminent |
| **RSI Momentum** | 12 | RSI in the sweet spot (not overbought/oversold) |
| **Range Position** | 8 | Where price sits within today's high/low range |
| **Candle Momentum** | 8 | Consecutive bars moving in signal direction |

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
  [OK] No imminent economic events - clear window to trade.
```

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

### macOS

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
2. Click **Start** to begin auto-scanning every 60 seconds
3. Or click **Scan Now** for an immediate check
4. When a signal fires you'll see:
   - Signal type (CALL / PUT) with quality score and letter grade
   - DTE recommendation (0, 1, or 2 DTE with reasoning)
   - Plain-English explanation of the rating
   - Candlestick chart with RSI and MACD
   - Hold-time recommendation with exit time in ET
   - Recommended option strikes
5. Click **Value Scanner** to find mispriced options contracts
6. Use tabs on the right panel: Signal, Hold, Calendar, Log

### Top Bar Settings

- **Calls / Puts** -- toggle which directions you want alerts for
- **Min** -- minimum grade to trigger alerts (default: C)
- **Vol** -- volume ratio required to trigger (default: 150% = 1.5x average)

---

## Timezone Handling

All market-sensitive logic runs in **US Eastern Time** regardless of your local timezone. Uses `zoneinfo` (Python 3.9+) with `pytz` fallback. Hold time exit times, market close caps, event countdowns, and intraday zones all reference ET market hours.

---

## Project Structure

```
SPYderScalp/
  spyer.py                  # Main app (signals, chart, calendar, scanner, UI)
  sf.jpg                    # App logo
  SPYderScalp.bat           # Windows smart launcher (double-click to run)
  requirements.txt          # Python dependencies
  install_windows.ps1       # Windows PowerShell installer (alternative)
  LICENSE                   # MIT license
  README.md                 # This file
```

---

## Roadmap

- [x] Multi-indicator signal scoring
- [x] Candlestick chart with RSI & MACD
- [x] Economic calendar (2025-2026)
- [x] Hold-time recommendations
- [x] Plain-English signal explanations
- [x] Side-by-side layout for laptops
- [x] Eastern Time awareness
- [x] DTE recommender (0/1/2 DTE)
- [x] Options value scanner (mispriced contracts)
- [ ] RSI divergence signals
- [ ] Trade journal / win-loss tracking
- [ ] Real-time data source integration
- [ ] Auto-trade via broker API (Tradier, IBKR)

---

## Disclaimer

This app provides **alerts only**, not financial advice. Always verify signals before trading. 0DTE options are extremely risky -- use proper position sizing and risk management.

---

## License

MIT -- see [LICENSE](LICENSE).
