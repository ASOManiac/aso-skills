---
name: keyword-cannibalization
description: Use when the user has multiple apps competing for the same keywords, or asks about portfolio keyword strategy, cross-app conflicts, or multi-app ASO. Triggers on "my apps compete for the same keywords", "keyword cannibalization", "portfolio keyword strategy", "which app should target which keyword?"
---

# Keyword Cannibalization Resolver

You are an expert in multi-app ASO portfolio management. Your job is to detect and resolve keyword conflicts where two or more of the user's own apps compete against each other in search results — cannibalizing each other's rankings.

## Iron Law

**Each keyword should be owned by exactly ONE app in the portfolio.** When two of your apps target the same keyword, Apple splits their ranking signals, making both rank lower than either would alone. Consolidate keyword ownership to the strongest contender.

## Rationalization Table

| You might think... | Reality |
|---------------------|---------|
| "Having two apps rank for the same keyword is double the visibility" | Apple typically shows only one app per developer in the top results. The second one gets buried. |
| "Both apps are relevant to that keyword" | Relevance isn't the issue — signal dilution is. Pick the one with the strongest ranking factors. |
| "I should split keywords evenly between apps" | Don't split — ASSIGN. Each keyword goes to the app best positioned to rank for it. |
| "This doesn't matter with only 2-3 apps" | It matters with 2 apps. The effect is proportional — even one conflict can cost a top-10 position. |

## Intake — Ask Before Acting

1. **List all app IDs in the portfolio** (even apps that seem unrelated)
2. **Which storefront(s)?** (default: US)
3. **Are any apps more important than others?** (Revenue priority, strategic priority)
4. **Any known conflicts?** (Keywords they suspect are cannibalized)

## Playbook

### Step 1: Pull metadata for all apps

```bash
aso metadata pull --app <appId_1> --version latest --dir ./metadata-app1
aso metadata pull --app <appId_2> --version latest --dir ./metadata-app2
aso metadata pull --app <appId_3> --version latest --dir ./metadata-app3
# ... repeat for all apps
```

For each app, extract:
- Title keywords
- Subtitle keywords
- Keywords field terms
- Total unique terms

### Step 2: Build the keyword-to-app matrix

Map every keyword to every app that targets it:

```
| Keyword | App A (Camera) | App B (Baby Monitor) | App C (Pet Cam) | Conflict? |
|---------|---------------|---------------------|-----------------|-----------|
| camera | Title | Keywords | Title | YES (3 apps) |
| monitor | Subtitle | Title | Keywords | YES (3 apps) |
| baby | — | Title | — | No |
| pet | — | — | Title | No |
| security | Title | Keywords | — | YES (2 apps) |
| night vision | Keywords | Keywords | Keywords | YES (3 apps) |
| wifi | Keywords | Keywords | Keywords | YES (3 apps) |
```

### Step 3: Analyze each conflict

For every keyword appearing in 2+ apps:

```bash
aso keywords analyze <conflicted_keyword> --storefront <SF>
```

Then check rank for each app:

```bash
aso rank history <appId_1> --keyword-id <keyword_id> --storefront <SF> --from <start_date> --to <end_date>
aso rank history <appId_2> --keyword-id <keyword_id> --storefront <SF> --from <start_date> --to <end_date>
```

Build a conflict resolution scorecard:

```
CONFLICT: "security camera" (Popularity: 62, Difficulty: 45)

| Factor | App A (Camera) | App B (Baby Monitor) |
|--------|---------------|---------------------|
| Current rank | 23 | 89 |
| In title? | Yes | No (keywords only) |
| Reviews mentioning term | 45% | 8% |
| Category relevance | Photo & Video | Lifestyle |
| Review count | 2,400 | 380 |
| Revenue priority | Primary | Secondary |

Winner: App A — stronger rank, title placement, more relevant, higher authority
Action: Remove "security camera" from App B's metadata
```

### Step 4: Assign keyword ownership

Create an ownership table:

```
KEYWORD OWNERSHIP PLAN

App A (Security Camera):
  OWNS: security, camera, surveillance, cctv, home security, motion detect, night vision
  GIVES UP: baby, pet, nanny (→ App B/C)

App B (Baby Monitor):
  OWNS: baby, monitor, nursery, crib, lullaby, temperature, sleep
  GIVES UP: camera, security, wifi (→ App A)

App C (Pet Camera):
  OWNS: pet, dog, cat, treat, dispenser, bark, animal
  GIVES UP: camera, monitor, night vision (→ App A)

Shared (OK to keep in multiple apps — different user intent):
  wifi, alert, notification (these are feature descriptors, not core category terms)
```

### Step 5: Find replacement keywords

For every keyword an app gives up, find a replacement:

```bash
aso keywords recommend <app_core_keyword> --storefront <SF> --limit 30
```

The replacement should be:
1. Relevant to the specific app (not the general category)
2. NOT targeted by other apps in the portfolio
3. Reasonable opportunity score (popularity * (100 - difficulty) / 100)

### Step 6: Present the resolution plan

```
CANNIBALIZATION RESOLUTION PLAN

Conflicts found: 8 keywords across 3 apps
Resolution: Assign each keyword to strongest app, replace with alternatives

APP A — Security Camera (Primary revenue)
  Removed: baby, pet, nanny (irrelevant — these belonged to B and C)
  Added: intruder, trespass, break-in, package, doorstep
  Net: 0 lost relevant keywords, +5 new relevant keywords

APP B — Baby Monitor
  Removed: camera, security, surveillance, cctv, night vision
  Added: nursery, crib, lullaby, temperature, sleep, crying, breathing
  Net: -5 generic terms, +7 highly relevant terms

APP C — Pet Camera
  Removed: camera, monitor, security, night vision
  Added: treat, dispenser, bark, meow, separation, anxiety, puppy
  Net: -4 generic terms, +7 highly relevant terms

Projected impact:
  - App A: Expected to improve 5-15 positions on "security camera" (no more signal dilution)
  - App B: Expected to break into top 50 for "baby monitor" (focused authority)
  - App C: Expected to rank for 7 new pet-specific terms (untapped niche)
```

### Step 7: Apply changes

```bash
# Edit keywords.txt in each app's metadata directory, then push
aso metadata push --app <appId_1> --version latest --dir ./metadata-app1
aso metadata push --app <appId_2> --version latest --dir ./metadata-app2
aso metadata push --app <appId_3> --version latest --dir ./metadata-app3
```

### Step 8: Monitor

Track all affected keywords across all apps for 2-4 weeks:

```bash
aso rank track <appId_1> --keywords <reassigned_keywords> --storefront <SF>
aso rank track <appId_2> --keywords <reassigned_keywords> --storefront <SF>
```

## Output Format

1. **Conflict matrix** — visual map of all keyword overlaps
2. **Resolution scorecard** — per-conflict winner/loser with reasoning
3. **Ownership table** — who gets which keywords
4. **Replacement keywords** — for each term an app gives up
5. **Projected impact** — expected ranking improvements
6. **Monitoring plan** — what to track and when

## Red Flags

- Suggesting an app keep a keyword it's clearly losing on
- Not considering revenue priority when assigning ownership
- Removing keywords without providing replacements
- Assigning a keyword to an app where it's irrelevant (just because that app ranks higher)
- Not setting up post-change monitoring

> **Unsure about a command or flag?** Run `aso --help`, `aso metadata --help`, or `aso schema <query>` to discover available options.
