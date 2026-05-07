# Output format guidelines

Reusable structure for skill outputs. Skip sections that do not apply, but keep the order. Practical examples > prose.

## 1. Executive summary

1-3 sentences. State the headline finding or change. No tables, no lists, no caveats.

> Optimized en-US metadata: keywords field went from 72/100 to 98/100, indexed terms 6 → 19, all 11 quality gates pass.

## 2. Input confirmation

Echo back the inputs you used so the user can spot a wrong assumption immediately.

```
App: Homy (123456789)
Storefront: US
Locale: en-US
Constraints: keep "Homy" in title, do not change category
```

## 3. Data tables

Use tables for anything that is naturally tabular. Pick the variant that fits the skill.

### Keyword scorecard

```
| # | Keyword         | Pop | Diff | Opportunity | Field    | Verdict |
|---|-----------------|-----|------|-------------|----------|---------|
| 1 | security camera | 62  | 45   | 34.1        | title    | KEEP    |
| 2 | home monitor    | 48  | 22   | 37.4        | subtitle | KEEP    |
| 3 | nanny cam       | 35  | 15   | 29.8        | keywords | ADD     |
```

### Competitive matrix

```
| Keyword         | You | Comp A | Comp B | Pop | Diff |
|-----------------|-----|--------|--------|-----|------|
| security camera | 45  | 12     | 8      | 62  | 78   |
| baby cam        | —   | 5      | —      | 44  | 28   |
```

### Locale coverage

```
| Locale | Title | Subtitle | Keywords | Chars   | Unique terms |
|--------|-------|----------|----------|---------|--------------|
| en-US  | Yes   | Yes      | Yes (98) | 152/160 | 19           |
| en-GB  | —     | —        | —        | 0/160   | 0            |
```

### Quality gates checklist

```
[PASS] No keyword repetition
[PASS] Singular forms
[FAIL] Character utilization — keywords 72/100
[WARN] Subtitle value prop — reads more like keyword list
```

## 4. Findings / recommendations

Group by priority. Each item: action + reason + measurable impact.

```
PRIORITY 1 (quick wins)
  1. Remove spaces after commas → +12 chars (3 new keywords)
  2. Replace "cameras" → "camera" → +1 char

PRIORITY 2 (medium effort)
  3. Replace 4 low-opportunity keywords (pop < 10) → estimated +8 indexed terms

PRIORITY 3 (high effort, high impact)
  4. Fill es-MX and zh-Hans locales → +320 indexed chars
```

## 5. Change summary (BEFORE / AFTER)

Show the diff in one block. Include character counts.

```
BEFORE:
  Title:    "Homy - Security Cameras App"   (27/30)
  Subtitle: "Home Security Camera Monitor"   (30/30)
  Keywords: "cameras, security, home, baby"  (52/100)

AFTER:
  Title:    "Homy - Security Camera"         (22/30)
  Subtitle: "Home Monitor & Baby Cam"        (23/30)
  Keywords: "surveillance,pet,nanny,wifi,motion,detect,indoor,night,vision,alert,live,view,record,notification,two-way"
            (98/100)

Net: +13 indexed terms, -3 quality gate violations
```

## 6. Deployment instructions

Show the exact commands to apply changes. fastlane is the primary path; App Store Connect CLI only for TestFlight feedback / crashes.

### fastlane (primary)

```bash
# Pull current metadata to local working tree
fastlane deliver download_metadata

# Edit fastlane/metadata/<locale>/{name.txt,subtitle.txt,keywords.txt}

# Push metadata back to App Store Connect
fastlane deliver
```

### App Store Connect CLI (TestFlight feedback / crashes only)

```bash
asc testflight feedback list --app <appId>
asc testflight crashes list  --app <appId>
```

## 7. Next steps / backlog

3-5 actionable follow-ups. Each one should answer "what would I do next session?".

1. Re-run audit in 4 weeks once changes settle.
2. Research keywords for es-MX and fr-CA.
3. A/B test subtitle variant once you have ≥1k weekly impressions.
4. Add 3 quick-win keywords surfaced by competitor analysis.
5. Schedule a manual rank check in 2 weeks.
