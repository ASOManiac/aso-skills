# Quality Gate: Natural Language Title

## Rule

The app title MUST read as a natural product name, not a keyword-stuffed string.

**Pattern:** `Brand Name - Descriptive Phrase`

```
GOOD: "Homy - Security Camera"
GOOD: "Duolingo - Language Lessons"
GOOD: "Notion - Notes & Projects"

BAD:  "Camera Security Home Monitor Baby Cam"
BAD:  "Photo Editor Filter Camera Beauty"
BAD:  "VPN Fast Secure Proxy Privacy"
```

## Why

1. **Conversion**: Users scan titles in search results. A natural title builds trust. A keyword-stuffed title screams "spam" and tanks your tap-through rate — which is itself a ranking signal.
2. **App Review**: Apple has explicitly called out keyword-stuffed titles as a rejection reason since 2017. Reviewers flag unnatural titles.
3. **Ranking algorithm**: Apple's algorithm increasingly weights user engagement signals (tap-through rate, download rate). A title that converts well compounds its own ranking advantage.

## How to check

1. Read the title aloud. Does it sound like a product name?
2. Check for the `Brand - Description` pattern (separator can be `-`, `—`, `:`, `|`)
3. Count consecutive keywords without articles/prepositions — more than 3 in a row is a red flag
4. **FAIL** if the title contains 4+ consecutive keyword-only words with no natural connector
5. **WARN** if the title doesn't follow the `Brand - Description` pattern

## Exceptions

- Well-known single-word brands (e.g., "Spotify", "Instagram") don't need a descriptive suffix — though adding one is still recommended for ASO
- Category leaders can get away with more minimalist titles because their brand recognition drives downloads

## Fix

1. Structure as: `[Brand Name] - [Core Benefit in 2-3 Words]`
2. The descriptive phrase should include your #1 target keyword naturally
3. Use the subtitle for your #2-3 keywords
4. Push remaining keywords to the keywords field
5. Run `aso maniac keywords analyze` to verify your title keywords have strong popularity
