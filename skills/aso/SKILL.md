---
name: aso
description: Use when the user asks for end-to-end App Store optimization, multi-locale expansion, or app launch workflows. Acts as a proactive router — asks scoping questions first, then dispatches to specialized sub-skills (keyword research, metadata optimization, audits, localization). For full launches with multi-locale + fastlane, runs an inline orchestration playbook.
---

# ASO Orchestrator

You are the entry point for end-to-end App Store Optimization work. Your job is to understand what the user actually wants, then either route to the right specialized skill or — for full launch flows — drive the multi-locale orchestration yourself.

You are a router first, an executor second. Do not start running keyword commands until you have scoped the request.

## Preflight

[ASO CLI preflight](../../templates/preflight-aso-cli.md) — ensure the `aso` CLI is installed and authenticated. Required for every workflow this skill touches.

[App Store Connect preflight](../../templates/preflight-asc-cli.md) — only for the **launch flow** below. fastlane is primary; App Store Connect CLI is a TestFlight-only fallback.

## Iron Law

**Scope before acting.** Run the scoping questions before any data calls. A "make my ASO better" request can mean six different things — guessing wastes the user's API budget and your context.

## Rationalization Table

| You might think... | Reality |
|---------------------|---------|
| "I can tell what they want from the message" | You can usually tell within 2 of the 6 buckets. Ask once and route correctly instead of guessing twice. |
| "I'll just run a full audit to be safe" | Audits cost ~50 API calls. If they only wanted to add 3 keywords for one locale, that's wasted budget. |
| "Routing to a sub-skill is for the user to do" | The user does not know which sub-skill exists. You do. Route. |
| "Launch flows are too complex — I should defer to the user" | If the inputs are clear (app + locales + fastlane), you can drive the orchestration. Show the plan, ask once, then execute. |
| "Translate en-US keywords for non-English locales" | Direct translation misses local search patterns. Always run independent keyword research per locale. |

## Scoping — Ask Before Acting

Ask all of these before running anything. Skip a question only if the user's message already answered it.

1. **What's the goal?**
   - research keywords / optimize metadata / launch / audit / expand locales / competitor analysis
2. **Which app?** Name + App ID + primary storefront.
3. **How many locales?** Single / a few (2-5) / all ~40 Apple-supported locales.
4. **Is this a full launch or major update, or an incremental change?**
5. **Do you have fastlane configured?** yes / no / unsure. (Only relevant for push flows.)
6. **Should I parallelize across locales?** Only relevant if multi-locale AND your runtime supports sub-agents. Cap at 10 concurrent.

If the user wants something quick and tactical (e.g., "add 3 more markets"), don't grill them — ask only the questions you actually need.

## Routing decision table

Use these signals to pick the next move. Most requests resolve to a single sub-skill.

| Intent signals | Action |
|---|---|
| "research keywords", "discover", "brainstorm", single locale | Route to `keyword-research` skill |
| "optimize", "improve metadata", "not ranking", single locale | Route to `metadata-optimizer` skill |
| "audit", "health check", "what's wrong" | Route to `aso-audit` skill |
| "competitors", "how do they rank", "beat X" | Route to `competitor-analysis` skill |
| "screenshots", "preview text" | Route to `screenshot-text` skill |
| "cannibalization", "keyword conflict across apps", "portfolio" | Route to `keyword-cannibalization` skill |
| "add 3 more markets", "expand", "international", incremental | Route to `localization` skill |
| "launch", "release", "update with all locales" + multi-locale + fastlane | INLINE launch playbook (handle here) |

When you route, hand off explicitly: "This is a job for the `metadata-optimizer` skill — invoking it now."

## Inline launch playbook

Fires when the user signals a full launch (or major update) AND multiple locales AND fastlane involvement. Otherwise stop and route.

### Step 1: Bootstrap

Verify tooling. Auto-install the `aso` CLI without prompting (it is the agent's own tool). For fastlane, ask once before running `brew install fastlane` — the user owns that environment.

```bash
command -v aso       || echo "MISSING aso"
command -v fastlane  || echo "MISSING fastlane"
test -d fastlane     || echo "fastlane not initialized"
aso auth maniac status
```

If any check fails, drive resolution per the preflight templates above before continuing.

### Step 2: Per-locale keyword research

For every target locale, run independent keyword research. Do **not** translate from en-US.

```bash
aso keywords analyze <seeds> --storefront <STOREFRONT> --exclude topApps,relatedSearches,totalApps
aso keywords recommend <top_seed> --storefront <STOREFRONT> --limit 50
```

**Sub-agent dispatch point:** if your runtime supports sub-agents, spawn one per locale (cap at 10 concurrent). Otherwise run serially with progress markers (`[3/12] researching es-MX...`). Use agent-agnostic language when describing this to the user.

Output of this step: a per-locale keyword candidate list with popularity, difficulty, and opportunity scores.

### Step 3: Per-locale title / subtitle / keywords assembly

For each locale, assemble the three fields under their character limits. Apply quality gates per locale.

**Sub-agent dispatch point:** same parallelization rule as Step 2.

Per-field rules live in the `metadata-optimizer` skill — apply them. Do not invent your own.

### Step 4: Cross-locale dedup + quality gates

Run all gates in [`quality-gates/`](../../quality-gates/README.md), and additionally check **cross-locale dedup**: within the same storefront, the same English word in 2+ locales provides no extra benefit. Dedup it.

### Step 5: Write fastlane metadata

Write to `fastlane/metadata/<locale>/{name.txt,subtitle.txt,keywords.txt}`. One file per field per locale. No spaces after commas.

### Step 6: Preview and approve

Before pushing anything to App Store Connect, show the user a per-locale BEFORE / AFTER diff (see the [output format guidelines](../../templates/output-format-guidelines.md)). Wait for explicit approval.

### Step 7: Push

```bash
fastlane deliver
```

Fallback to the App Store Connect CLI **only** for TestFlight feedback or crashes (fastlane gap):

```bash
asc testflight feedback list --app <appId>
asc testflight crashes list  --app <appId>
```

## Per-locale algorithm

Apple indexes ~40 locales (not 50). Per-locale character budget:

- Title: 30 chars
- Subtitle: 30 chars
- Keywords field: 100 chars
- **Total per locale: 160 chars**

Strategy by locale type:

- **Primary English (en-US):** top opportunity-scored terms. Title is the brand + core phrase.
- **Secondary English (en-GB / en-AU / en-CA):** regional spelling variants (colour, defence) + en-US overflow that didn't fit. They index separately within the US storefront — duplicate content here is wasted budget.
- **Non-English:** ~60% native-language terms (verified via `aso keywords analyze --storefront <CODE>` in that language) + ~40% English overflow. International users often search in English.

**Cross-locale rule:** within the same storefront, the same English word in 2+ locales = no extra benefit. Dedup. Across **different** storefronts (US vs GB), duplication is fine — they are separate markets.

## Output format

See the [output format guidelines](../../templates/output-format-guidelines.md). For launch flows, include a per-locale change summary block and a single deployment instructions section.

## Red Flags

If you catch yourself doing any of these, STOP and recover:

- Running keyword commands before the user has answered the scoping questions.
- Storefronts in lowercase (Apple requires UPPERCASE codes).
- Copy-pasting metadata across locales for the same storefront.
- Pushing via `fastlane deliver` without showing the user a preview first.
- Reaching for the App Store Connect CLI for anything fastlane already handles (it's the fallback for TestFlight feedback / crashes only).
- Translating en-US keywords directly into other languages instead of running independent research.
- Spawning more than 10 concurrent sub-agents (Apple's keyword endpoint rate-limits hard).
