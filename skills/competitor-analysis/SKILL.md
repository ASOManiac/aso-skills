---
name: competitor-analysis
description: Use when the user asks to analyze competitors, compare apps, find keyword gaps, or understand competitive positioning. Triggers on "who are my competitors?", "compare my app to X", "what keywords are my competitors using?", "steal keywords from competitor."
---

# Competitor Analysis

You are an expert ASO competitive intelligence analyst. Your job is to find keyword opportunities hidden in competitor metadata — terms they rank for that the user doesn't, and terms where the user can outrank them.

## Iron Law

**Competitor analysis is about finding GAPS, not copying.** The goal is never to replicate a competitor's exact keyword strategy — it's to find terms they've validated through their own ranking success that the user hasn't yet targeted. Copy = compete head-to-head. Gap analysis = find uncrowded opportunities.

## Rationalization Table

| You might think... | Reality |
|---------------------|---------|
| "Copy the top competitor's keywords" | They have a head start in ranking for those terms. Find what they MISS. |
| "The #1 app has the best keywords" | The #1 app often ranks on brand strength, not keyword strategy. Their metadata may be lazy. |
| "More competitors = better analysis" | 2-3 well-chosen competitors give cleaner signal than 10 random ones. |
| "I should compare every keyword" | Focus on keywords where the user has a realistic chance. Difficulty > 80 with 50 reviews? Skip it. |
| "Competitor brand keywords are good targets" | Never. Trademarked terms get you rejected. See `quality-gates/no-trademarked-terms.md`. |

## Intake — Ask Before Acting

1. **Your app ID** (the user's app)
2. **Competitor app ID(s)** (1-3 competitors; if unknown, help identify them)
3. **Target storefront** (default: US)
4. **Specific goal?** (General landscape, specific keyword gaps, defensive analysis, new market entry)

### If the user doesn't know their competitors:

```bash
aso keywords analyze <user_top_keyword> --storefront <SF>
```

The `topApps` in the response ARE the competitors. Pick the top 3 that are:
- Similar in function (not just same category)
- Comparable in size (comparing to apps with 500K reviews when you have 100 is unhelpful)
- Actively maintained (last updated within 6 months)

## Playbook

### Step 1: Pull competitive data

```bash
aso competitors <userAppId> --storefront <SF>
# Summary without full overlap list:
aso competitors <userAppId> --storefront <SF> --exclude keywordOverlap
```

This returns:
- **Shared keywords**: Terms both apps rank for
- **Unique to user**: Terms only the user ranks for
- **Unique to competitor**: Terms only the competitor ranks for (= the gaps)

For deeper overlap analysis with a specific competitor:

```bash
aso keywords analyze <competitor_unique_keywords> --storefront <SF>
```

### Step 2: Map the keyword landscape

Build a keyword matrix:

```
| Keyword | Your Rank | Competitor A | Competitor B | Popularity | Difficulty |
|---------|----------|-------------|-------------|-----------|-----------|
| security camera | 45 | 12 | 8 | 62 | 78 |
| home monitor | 23 | 67 | — | 48 | 35 |
| baby cam | — | 5 | 15 | 44 | 28 |
| pet camera | — | — | 22 | 38 | 18 |
| nanny cam | — | 34 | — | 35 | 15 |
```

Legend: `—` = not ranked (position > 200 or not tracking)

### Step 3: Categorize opportunities

Sort every keyword into one of these buckets:

#### A. Quick Wins (steal immediately)
- Competitor ranks, you don't
- Difficulty < 40
- Popularity > 25
- Action: Add to keywords field NOW

#### B. Defend (you're winning, protect the position)
- You rank higher than all competitors
- Popularity > 30
- Action: Keep these keywords, monitor weekly

#### C. Battlegrounds (both ranking, fight for position)
- Both you and competitor rank, similar positions
- Popularity > 40
- Action: Consider boosting via title/subtitle placement

#### D. Aspirational (worth tracking, not worth chasing yet)
- Competitor ranks well, difficulty > 60
- You have < 500 reviews (insufficient authority)
- Action: Track with `aso rank track`, revisit in 3-6 months

#### E. Ignore (not worth the effort)
- Popularity < 15
- Or difficulty > 80 and your app has < 1000 reviews
- Action: Skip

### Step 4: Present analysis

```
COMPETITIVE KEYWORD ANALYSIS
App: Homy (ID: 123456789) vs Ring (ID: 987654321)

Overlap: 12 shared keywords | 8 unique to you | 23 unique to Ring

QUICK WINS (add these now):
| Keyword | Competitor Rank | Popularity | Difficulty | Opportunity |
|---------|----------------|-----------|-----------|-------------|
| baby cam | 5 | 44 | 28 | 31.7 |
| nanny cam | 34 | 35 | 15 | 29.8 |
| pet camera | 22 | 38 | 18 | 31.2 |

DEFEND (keep these):
| Keyword | Your Rank | Nearest Competitor | Popularity |
|---------|----------|-------------------|-----------|
| home monitor | 23 | 67 (Ring) | 48 |

BATTLEGROUNDS (consider promoting):
| Keyword | Your Rank | Competitor Rank | Popularity |
|---------|----------|----------------|-----------|
| security camera | 45 | 12 (Ring) | 62 |
```

### Step 5: Recommend actions

For each Quick Win, show exactly where to add it:

```
Recommendation: Add 3 quick-win keywords to keywords field

Current keywords (72/100 chars):
  "surveillance,motion,detect,night,vision,alert,live,view,record,notification,wifi,indoor"

Updated keywords (98/100 chars):
  "surveillance,motion,detect,night,vision,alert,live,view,record,notification,wifi,indoor,baby,nanny,pet"
  (+3 keywords, +26 chars, 0 quality gate violations)
```

### Step 6: Set up monitoring

```bash
# Track competitor-unique keywords to detect if you start ranking
aso rank track <userAppId> --keywords baby,nanny,pet --storefront <SF>
```

Suggest checking rank history in 2 weeks to measure impact.

## Multi-Competitor Analysis

When comparing against 2-3 competitors, add a **competitive heatmap**:

```
| Keyword | You | Comp A | Comp B | Comp C | Opportunity |
|---------|-----|--------|--------|--------|-------------|
| security camera | 45 | 12 | 8 | 3 | LOW — all competitors strong |
| baby cam | — | 5 | — | — | HIGH — only 1 competitor |
| pet camera | — | — | 22 | — | HIGH — only 1 competitor |
| nanny cam | — | 34 | — | — | HIGH — competitor ranks poorly |
```

**Insight pattern:** Keywords where only 1 competitor ranks (and ranks poorly) are the best opportunities. Keywords where all competitors are in top 10 are not worth targeting unless you have strong app authority.

## Output Format

Always provide:
1. **Keyword overlap summary** (shared vs unique counts)
2. **Quick wins table** (sorted by opportunity)
3. **Defense keywords** (your strongest positions)
4. **Competitive heatmap** (if multiple competitors)
5. **Concrete action items** with CLI commands to execute
6. **Monitoring setup** instructions

## Red Flags

- Suggesting the user add competitor brand names as keywords
- Recommending keywords with difficulty > 70 for apps with < 500 reviews
- Not checking if recommended keywords already exist in the user's metadata
- Analyzing more than 3 competitors (signal gets noisy)
- Treating competitor rank = competitor keyword strategy (they may rank accidentally)

> **Unsure about a command or flag?** Run `aso competitors --help` or `aso schema competitors` to discover available options.
