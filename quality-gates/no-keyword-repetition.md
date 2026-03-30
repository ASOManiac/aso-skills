# Quality Gate: No Keyword Repetition

## Rule

A keyword that appears in the **title** MUST NOT appear in the subtitle or keywords field.
A keyword that appears in the **subtitle** MUST NOT appear in the keywords field.

Each word should exist in exactly ONE metadata field.

## Why

Apple indexes title, subtitle, and keywords field independently. Every word in any of these three fields contributes to your search ranking for that term. Repeating a word across fields provides **zero additional ranking benefit** — you gain nothing but waste precious indexed characters.

At 30 + 30 + 100 = 160 characters total, every wasted character is a keyword you could have ranked for.

## How to check

1. Extract all words from title (split on spaces)
2. Extract all words from subtitle (split on spaces)
3. Extract all terms from keywords field (split on commas)
4. Normalize: lowercase, trim whitespace
5. Build a frequency map across all three fields
6. **FAIL** if any word appears in more than one field

### Example

```
Title:    "Homy - Security Camera"
Subtitle: "Home Security Monitor"      <- "Security" repeats from title!
Keywords: "camera,home,baby,monitor"    <- "camera" repeats from title!
                                        <- "home" repeats from subtitle!
                                        <- "monitor" repeats from subtitle!
```

**Fixed:**
```
Title:    "Homy - Security Camera"
Subtitle: "Home Monitor & Baby Cam"
Keywords: "surveillance,pet,nanny,wifi,motion,detect,indoor,night,vision,alert"
```

## Exceptions

None. This rule has no exceptions. Even common words like "app" or "free" should not be repeated.

## Fix

1. Identify which field the repeated word has the highest impact in (title > subtitle > keywords)
2. Keep the word in the highest-priority field only
3. Replace it in lower-priority fields with a new keyword from your research
4. Re-run `aso maniac keywords analyze` on the replacement candidates to pick the best alternative
