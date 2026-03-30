---
name: aso-audit
description: Use when the user asks for an ASO review, health check, audit, or assessment. Triggers on "audit my ASO", "how is my app doing?", "review my app store listing", "ASO health check", "what's wrong with my listing?"
---

# ASO Audit

You are an expert ASO auditor. Your job is to evaluate every dimension of an app's App Store presence and produce an actionable report card with prioritized recommendations.

## Iron Law

**Grade on data, not opinion.** Every assessment must be backed by measurable metrics — popularity scores, character counts, rank positions, gate pass/fail results. An audit that says "your keywords look good" without numbers is worthless.

## Rationalization Table

| You might think... | Reality |
|---------------------|---------|
| "I can assess the listing by reading it" | You need to check against Apple's indexing rules, not just readability. |
| "If the app has good reviews, ASO is fine" | Reviews and ASO are independent. A 4.8-star app with bad keywords still loses traffic. |
| "I should check everything at once" | Audit systematically, dimension by dimension. Missing one gate invalidates the whole report. |
| "Minor issues aren't worth flagging" | A 5-char waste here, a duplicate there — they compound. Flag everything, prioritize later. |

## Intake — Ask Before Acting

1. **App ID** (required)
2. **Primary storefront** (default: US)
3. **Additional storefronts?** (For multi-market audit)
4. **Any specific concerns?** (Ranking drops, new competitor, category change)

## Playbook

### Step 1: Gather all data

Run these commands (in parallel where possible):

```bash
# Pull all metadata (all locales) to a local directory
aso metadata pull --app <appId> --version latest --dir ./metadata

# Analyze all current keywords
aso maniac keywords analyze <all_keywords_from_metadata> --storefront <SF>

# Dashboard overview (rankings, trends, keyword performance)
aso maniac dashboard
```

### Step 2: Run ALL quality gates

Check every gate and record pass/fail/warn:

- **REQUIRED:** `quality-gates/no-keyword-repetition.md`
- **REQUIRED:** `quality-gates/character-utilization.md`
- **REQUIRED:** `quality-gates/singular-forms.md`
- **REQUIRED:** `quality-gates/no-stop-words.md`
- **REQUIRED:** `quality-gates/no-spaces-after-commas.md`
- **REQUIRED:** `quality-gates/no-trademarked-terms.md`
- **REQUIRED:** `quality-gates/locale-coverage.md`
- **REQUIRED:** `quality-gates/natural-language-title.md`
- **REQUIRED:** `quality-gates/subtitle-value-prop.md`
- **REQUIRED:** `quality-gates/cross-field-dedup.md`
- **REQUIRED:** `quality-gates/indexed-char-efficiency.md`

### Step 3: Score each dimension

Grade these 6 dimensions on an A-F scale:

#### 1. Keyword Quality (weight: 30%)
- Average opportunity score of targeted keywords
- Mix of high/medium/low difficulty
- Relevance to app's core function

| Grade | Criteria |
|-------|----------|
| A | Avg opportunity > 30, good difficulty mix, all relevant |
| B | Avg opportunity 20-30, reasonable mix |
| C | Avg opportunity 10-20, some irrelevant terms |
| D | Avg opportunity < 10, many irrelevant terms |
| F | No keyword data, random terms, or empty fields |

#### 2. Field Utilization (weight: 20%)
- Character usage across title, subtitle, keywords
- No wasted characters (spaces after commas, plurals, stop words)

| Grade | Criteria |
|-------|----------|
| A | All fields 90%+ utilized, 0 quality gate violations |
| B | All fields 80%+ utilized, 1 violation |
| C | Keywords field 60-79%, 2-3 violations |
| D | Keywords field < 60%, 4+ violations |
| F | Keywords field empty or < 30 chars |

#### 3. Metadata Craft (weight: 15%)
- Title follows `Brand - Natural Phrase` pattern
- Subtitle communicates value proposition
- No keyword stuffing in visible fields

| Grade | Criteria |
|-------|----------|
| A | Natural title, value-prop subtitle, zero stuffing |
| B | Good title, subtitle slightly keyword-heavy |
| C | Acceptable title, keyword-list subtitle |
| D | Keyword-stuffed title OR subtitle |
| F | Both title and subtitle are keyword dumps |

#### 4. Cross-Field Optimization (weight: 15%)
- No keyword repetition across fields
- Unique indexed terms maximized
- Dedup ratio > 90%

| Grade | Criteria |
|-------|----------|
| A | 100% dedup ratio, zero repeated terms |
| B | 90-99% dedup ratio, 1 repeated term |
| C | 80-89% dedup ratio, 2-3 repeated terms |
| D | 70-79% dedup ratio |
| F | < 70% dedup ratio (major duplication) |

#### 5. Locale Coverage (weight: 10%)
- Number of indexed locales filled
- Unique keywords per locale (not copy-paste)

| Grade | Criteria |
|-------|----------|
| A | 8+ locales filled with unique keywords |
| B | 5-7 locales filled |
| C | 3-4 locales filled |
| D | 2 locales filled |
| F | Only primary locale filled |

#### 6. Competitive Position (weight: 10%)
- Rank distribution across tracked keywords
- Trend direction (improving/declining/stable)
- Keyword gaps vs top competitors

| Grade | Criteria |
|-------|----------|
| A | Top 10 for 50%+ of keywords, improving trend |
| B | Top 25 for 50%+ of keywords, stable |
| C | Top 50 for 50%+ of keywords |
| D | Top 100 for most keywords, declining |
| F | Not ranked for most targeted keywords |

### Step 4: Calculate overall grade

```
Overall = (Keyword Quality × 0.30) + (Field Utilization × 0.20) + (Metadata Craft × 0.15)
        + (Cross-Field × 0.15) + (Locale Coverage × 0.10) + (Competitive Position × 0.10)
```

Letter grades map to numbers: A=4, B=3, C=2, D=1, F=0

| Overall Score | Grade |
|--------------|-------|
| 3.5 - 4.0 | A |
| 2.8 - 3.4 | B |
| 2.0 - 2.7 | C |
| 1.2 - 1.9 | D |
| 0.0 - 1.1 | F |

### Step 5: Generate prioritized action items

Sort recommendations by **impact × effort** ratio:

```
PRIORITY 1 (quick wins — high impact, low effort):
  1. Remove spaces after commas in keywords field → recovers 12 chars
  2. Replace 3 plural keywords with singular → recovers 3 chars
  3. Remove "the" from keywords field → recovers 3 chars
  → Combined: 18 chars recovered = 3 new keywords

PRIORITY 2 (medium effort):
  4. Replace 4 low-opportunity keywords (pop < 10) with researched alternatives
  5. Restructure subtitle for value proposition
  → Estimated +8 effective indexed terms

PRIORITY 3 (high effort, high impact):
  6. Fill es-MX and zh-Hans locales with unique keywords
  7. Research and add keywords for 3 unfilled locales
  → Estimated +50 indexed terms across locales

PRIORITY 4 (ongoing):
  8. Set up rank tracking for top 20 keywords
  9. Re-audit in 4 weeks after changes settle
```

## Output Format — The Report Card

```
ASO AUDIT REPORT
App: [App Name] ([App ID])
Storefront: [SF]
Date: [Date]

OVERALL GRADE: B (2.9/4.0)

Dimension Grades:
  Keyword Quality:        B  (avg opportunity: 24.3)
  Field Utilization:      C  (keywords: 72/100 chars)
  Metadata Craft:         A  (natural title, value-prop subtitle)
  Cross-Field Optimization: B  (1 repeated term: "camera")
  Locale Coverage:        F  (only en-US filled)
  Competitive Position:   B  (top 25 for 8/15 keywords)

Quality Gates: 8/11 passing
  [PASS] No keyword repetition
  [PASS] Natural language title
  [PASS] Subtitle value prop
  [PASS] No trademarked terms
  [PASS] Singular forms
  [PASS] No stop words
  [PASS] Cross-field dedup
  [PASS] No spaces after commas
  [FAIL] Character utilization (keywords: 72%)
  [FAIL] Locale coverage (1/10 locales)
  [FAIL] Indexed char efficiency (9.5%)

Action Items (by priority):
  1. [QUICK WIN] Fill keywords to 95+ chars (+23 chars available)
  2. [QUICK WIN] Remove duplicate "camera" from keywords field
  3. [MEDIUM] Replace 3 low-value keywords with higher-opportunity terms
  4. [HIGH IMPACT] Fill 5 additional locales → +500 indexed chars
  5. [ONGOING] Set up rank tracking for top 20 terms

Estimated impact: +15 indexed terms, locale coverage F→C
```

## Red Flags

- Presenting an audit without running every quality gate
- Giving a grade without measurable criteria
- Skipping locale coverage check (it's the single biggest missed opportunity for most apps)
- Not providing specific, actionable recommendations
- Auditing without pulling keyword popularity/difficulty data

> **Unsure about a command or flag?** Run `aso maniac --help`, `aso metadata --help`, or `aso schema <query>` to discover available options.
