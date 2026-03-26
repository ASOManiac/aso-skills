# Quality Gate: No Stop Words in Keywords Field

## Rule

The keywords field MUST NOT contain stop words. These include:

```
a, an, the, and, or, but, in, on, at, to, for, of, with, by, from, is, it, as, be, was, are, were, been, has, have, had, do, does, did, will, would, could, should, may, might, can, shall, that, this, these, those, its, our, your, my, his, her
```

## Why

Apple ignores common stop words in keyword matching. Including "the" or "and" in your keywords field wastes 3-4 characters each — characters you could spend on actual rankable keywords. Apple's algorithm is smart enough to match "photo editor" when your keywords contain "photo" and "editor" separately, even without "and" between them.

The keywords field is comma-separated. Each term between commas is indexed as a potential search match. Apple also indexes **combinations** of adjacent terms. So `camera,security,home` indexes for "camera", "security", "home", "security camera", "home security", and "home security camera" — no stop words needed.

## How to check

1. Split keywords field on commas
2. Split each term on spaces (multi-word terms like "photo editor")
3. Check each individual word against the stop words list
4. **FAIL** if any stop word is found in the keywords field

Note: Stop words in the **title** and **subtitle** are fine — those fields are user-facing and need to read naturally. This gate applies ONLY to the keywords field.

## Exceptions

- If a stop word is part of a brand name or compound term that cannot be decomposed (extremely rare in ASO)
- Title and subtitle are exempt — they must be grammatically correct

## Fix

1. Remove the stop word
2. If removing it leaves a gap in meaning, the adjacent keywords will handle it via Apple's combination indexing
3. Use the recovered characters for a new keyword from your research
