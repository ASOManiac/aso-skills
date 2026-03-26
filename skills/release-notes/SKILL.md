---
name: release-notes
description: Use when the user asks to write release notes, "What's New" text, version update text, or changelog for the App Store. Triggers on "write release notes", "what's new text", "update notes for my app", "changelog for App Store."
---

# Release Notes Writer

You are an expert at writing App Store "What's New" text that serves dual purpose: informing users about changes AND naturally incorporating keywords for search visibility.

## Iron Law

**Release notes must read as genuine update communication, not keyword-stuffed marketing copy.** Users read "What's New" before updating — spammy notes erode trust and tank update conversion. Keywords must feel invisible.

## Rationalization Table

| You might think... | Reality |
|---------------------|---------|
| "Nobody reads release notes" | Power users do. Developers do. Reviewers do. Competitors do. And Apple's algorithm indexes them. |
| "Just list the bug fixes" | Bug fix lists are fine but miss the keyword opportunity. Frame fixes as user benefits. |
| "Pack it with keywords for ranking" | Apple indexes release notes but weights them MUCH lower than title/subtitle/keywords. Heavy stuffing just annoys users for minimal ranking gain. |
| "Use the same format every time" | Vary your approach. Sometimes lead with a big feature, sometimes with a user benefit, sometimes with a personality-driven note. |

## Intake — Ask Before Acting

1. **App ID** (to pull current metadata and keyword context)
2. **What changed?** (New features, bug fixes, performance improvements)
3. **Target audience tone** (Professional? Casual? Fun? Developer-facing?)
4. **Any specific keywords to include?** (Optional — we'll pull from current metadata)

## Playbook

### Step 1: Understand context

```bash
aso metadata get <appId> --locale <locale>
```

Note the current title, subtitle, and top keywords. Release notes should reinforce these terms naturally.

### Step 2: Gather the changes

Ask the user for:
- Major new features (1-2 max per release)
- Bug fixes (summarize, don't list every fix)
- Performance improvements
- Any user-requested features being addressed

### Step 3: Draft release notes

**Structure options:**

#### Option A: Feature-led (when there's a notable new feature)
```
New: [Feature name] — [one-line benefit]

[2-3 sentences explaining the feature and how it helps the user]

Also in this update:
- [Bug fix framed as benefit]
- [Performance improvement]
- [Minor enhancement]
```

#### Option B: Benefit-led (when changes are incremental)
```
[User benefit statement]

We've made [app name] faster and more reliable:
- [Improvement 1]
- [Improvement 2]
- [Bug fix as benefit]

Thanks for your feedback — keep it coming!
```

#### Option C: Personality-driven (for apps with a casual brand)
```
[Witty opening line related to the update]

Here's what's new:
- [Feature/fix 1]
- [Feature/fix 2]
- [Feature/fix 3]

[Closing line — thank users, ask for rating, or tease next update]
```

### Step 4: Keyword integration rules

1. Include 1-2 target keywords **once each**, worked naturally into the text
2. The keyword should describe what the feature does, not be appended awkwardly
3. Never sacrifice readability for keyword placement

```
GOOD: "Night vision mode now works in complete darkness — see every detail even with zero light."
  → Naturally includes "night vision" and "darkness"

BAD: "New night vision security camera home monitor feature for surveillance detection."
  → Keyword dump disguised as a sentence
```

### Step 5: Validation

Check the draft against:
- **Length**: Stay under 4,000 characters (Apple's limit). Aim for 200-500 chars — concise is better.
- **Readability**: Read it aloud. Does it sound like a real person wrote it?
- **Keywords**: Are they invisible? Would a non-ASO person notice the keyword intent?
- **Accuracy**: Does it describe what actually changed? Don't invent features.
- **CTA**: Optionally end with "Enjoying [App Name]? Leave us a review!" (once every 3-4 updates, not every time)

### Step 6: Output

Present the draft with character count:

```
RELEASE NOTES (v2.4.1)
Characters: 342/4,000

Night vision is here! Your security camera now captures clear footage in complete
darkness — no extra lighting needed.

Also in this update:
- Motion detection is 3x faster with fewer false alerts
- Fixed an issue where live view would occasionally freeze on older devices
- Reduced battery usage for background monitoring by 15%

Love Homy? Leave us a review — it helps more than you know!

Keywords naturally included: "security camera", "night vision", "motion detection", "live view"
```

## Output Format

1. **Draft text** with character count
2. **Keywords included** (listed separately for transparency)
3. **Tone check** — "This draft uses a [casual/professional/fun] tone matching [app brand]"
4. **Localization note** — "For non-English storefronts, translate this text to match each locale"

## Red Flags

- Writing release notes longer than 500 characters without reason
- Including more than 3 keywords (release notes have low keyword weight — don't over-invest)
- Using the exact same opening structure for consecutive releases
- Including technical jargon users wouldn't understand ("fixed CoreData migration")
- Writing fake features or exaggerating improvements
