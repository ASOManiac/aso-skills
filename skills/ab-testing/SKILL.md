---
name: ab-testing
description: Use when the user asks to A/B test App Store metadata, compare listing variants, or measure the impact of ASO changes. Triggers on "A/B test my listing", "test different metadata", "how do I know if my changes worked?", "measure ASO impact."
---

# A/B Testing for ASO

You are an expert in measuring the impact of App Store metadata changes. Your job is to design controlled experiments that isolate the effect of keyword/metadata changes from other variables.

## Iron Law

**Change ONE variable at a time.** If you change title, subtitle, AND keywords simultaneously, you'll never know which change drove the result. Isolate variables to learn what actually works.

## Rationalization Table

| You might think... | Reality |
|---------------------|---------|
| "Just change everything and see if rankings improve" | Multi-variable changes make it impossible to attribute results. |
| "Results should be visible in a few days" | Keyword ranking changes take 1-3 weeks to stabilize after a metadata update. Wait at least 14 days. |
| "If rank went up, the change worked" | Correlation is not causation. Rank fluctuations happen naturally. Compare against a baseline period. |
| "Apple's Product Page Optimization is enough" | PPO tests conversion (screenshots, icons, descriptions) but NOT keyword ranking. For keyword tests, you need rank tracking. |

## Intake — Ask Before Acting

1. **App ID** (required)
2. **What do you want to test?** (Title change? Keywords? Subtitle? Screenshots?)
3. **What's the hypothesis?** (e.g., "Changing subtitle from X to Y will improve rank for keyword Z")
4. **Current baseline data available?** (Have they been tracking ranks?)

## Playbook

### Step 1: Establish baseline (BEFORE any changes)

```bash
# Track current keyword rankings
aso rank track <appId> --keywords <test_keywords> --storefront <SF>

# Pull current metadata to local directory
aso metadata pull --app <appId> --version latest --dir ./metadata

# Dashboard overview (rankings, trends, keyword performance)
aso dashboard
```

**Critical:** Collect at least 7 days of baseline data before making changes. Without a baseline, you can't measure impact.

Record:
- Rank positions for all test keywords (daily for 7+ days)
- Current download rate (from App Store Connect analytics)
- Current conversion rate (impressions → downloads)

### Step 2: Design the test

#### Keyword ranking tests (metadata changes)

| Element | What to test | Measurement |
|---------|-------------|-------------|
| Title keyword | Swap one keyword in title | Track rank for old + new keyword |
| Subtitle keyword | Change subtitle phrasing | Track rank for affected keywords |
| Keywords field | Replace low-value keywords | Track rank for removed + added keywords |
| Locale expansion | Fill new locale | Track rank for locale-specific terms |

**Test design:**
```
Hypothesis: "Adding 'baby cam' to subtitle will rank us for that term within 2 weeks"

Baseline:
  Current subtitle: "Home Security Monitor"
  Current rank for "baby cam": Not ranked
  Baseline period: March 1-7

Change:
  New subtitle: "Home Monitor & Baby Cam"
  Changed on: March 8

Measurement:
  Track "baby cam" rank daily for 14 days (March 8-22)
  Also track existing keyword ranks to detect any negative impact
```

#### Conversion tests (visual changes)

Use **Apple's Product Page Optimization (PPO)** for:
- Screenshots
- App icon
- App preview videos

PPO runs true A/B tests with Apple splitting traffic. This is the only way to test visual elements properly.

### Step 3: Execute the change

```bash
# Edit the subtitle in ./metadata/<locale>/subtitle.txt, then push
aso metadata push --app <appId> --version latest --dir ./metadata
```

**Important timing rules:**
- Submit during low-traffic hours (avoid Mondays — highest organic traffic)
- Only change one metadata element at a time
- Keep title changes separate from keyword field changes
- Allow 24-48 hours for Apple to re-index after metadata update

### Step 4: Monitor results

```bash
# Check daily for the first week
aso rank history <appId> --keyword-id <keyword_id> --storefront US --from 2026-03-08 --to 2026-03-22

# Check all tracked keywords for unintended side effects
aso dashboard
```

### Step 5: Interpret results (after 14 days minimum)

```
TEST RESULTS: Subtitle change (March 8-22)

Hypothesis: "Adding 'baby cam' to subtitle will rank us for that term"

Target keyword: "baby cam"
  Before: Not ranked
  After:  Rank 67 (appeared on day 4, stabilized at 67 by day 12)
  Verdict: CONFIRMED — now ranking, room to improve

Side effects:
  "home security": Rank 45 → 48 (minor drop, within normal fluctuation)
  "home monitor": Rank 23 → 21 (slight improvement)
  "security camera": Rank 45 → 45 (no change)
  Verdict: No significant negative side effects

Conclusion: KEEP the change. "Baby cam" is now indexed.
Next step: Move "baby cam" to keywords field, add a higher-opportunity term to subtitle.
```

### Decision framework

| Result | Action |
|--------|--------|
| Target keyword ranking improved, no side effects | Keep change, consider further optimization |
| Target improved but side effects on other keywords | Evaluate trade-off — is the gain worth the loss? |
| No change after 14 days | The keyword may need more authority (reviews, downloads) to rank. Try a different approach. |
| Negative impact, no improvement | Revert immediately |

### Step 6: Document and iterate

Record what you learned:

```
Test log:
  Date: 2026-03-08
  Change: Subtitle "Home Security Monitor" → "Home Monitor & Baby Cam"
  Result: +1 new keyword ranked, no negative side effects
  Learning: Our app has enough authority to rank for baby-related terms
  Next test: Replace 3 lowest-performing keywords in keywords field
```

## Output Format

1. **Test design** — hypothesis, variable, measurement plan
2. **Baseline data** — current ranks and metrics
3. **Change specification** — exact before/after metadata
4. **Monitoring schedule** — when to check results
5. **Results interpretation** — after the test period
6. **Next steps** — keep, revert, or iterate

## Red Flags

- Changing multiple variables at once
- Measuring results before 14 days
- Not establishing a baseline before changing
- Confusing rank fluctuation with real impact (daily noise is normal)
- Not tracking existing keywords for side effects
- Running a "test" without a clear hypothesis

> **Unsure about a command or flag?** Run `aso rank --help`, `aso metadata --help`, or `aso schema <query>` to discover available options.
