# Quality Gate: Singular Forms

## Rule

Always use **singular** forms of keywords in the keywords field. Never use plurals.

- "camera" not "cameras"
- "photo" not "photos"
- "editor" not "editors"
- "scanner" not "scanners"

## Why

Apple's search algorithm automatically **stems** keywords. When you add "camera" to your keywords field, Apple indexes your app for "camera", "cameras", and "cameraing" (and other morphological variants). Adding "cameras" instead of "camera" provides identical indexing — but wastes 1 character on the trailing "s".

Over a 100-character keywords field, eliminating unnecessary plurals typically recovers 5-10 characters — enough for 1-2 additional keywords.

## How to check

1. Split keywords field on commas
2. For each term, check if it ends in "s" and the singular form is a real word
3. Common patterns to flag:
   - `*s` where removing "s" yields a valid word (cameras → camera)
   - `*es` where removing "es" yields a valid word (watches → watch)
   - `*ies` where replacing with "y" yields a valid word (batteries → battery)
4. **FAIL** if any plural form is found

## Exceptions

- Words where the singular and plural have **different search intent**: "glass" vs "glasses" (eyewear), "short" vs "shorts" (clothing)
- Words that are only used in plural form: "news", "physics", "scissors"
- Proper nouns: "iOS", "AirPods"

## Fix

1. Replace each plural with its singular form
2. Use the recovered characters to add new keywords
3. Verify with `aso maniac keywords analyze` that the singular form has equivalent or better popularity
