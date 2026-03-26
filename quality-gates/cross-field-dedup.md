# Quality Gate: Cross-Field Deduplication

## Rule

Maximize the number of **unique indexed terms** across title + subtitle + keywords. The combined set should have zero duplicates.

This is the aggregate version of "no-keyword-repetition" — applied as a holistic optimization metric rather than a per-word check.

## Why

Your total indexing budget is:
- Title: ~5-7 indexable words
- Subtitle: ~5-7 indexable words
- Keywords field: ~15-25 terms (comma-separated)

That's roughly 25-39 unique terms per locale. Every duplicate reduces this count by 1. With 10 indexed locales for US, a single duplicate across fields costs you 10 potential keyword slots.

## How to check

1. Extract all words from title (lowercase, split on spaces, remove punctuation)
2. Extract all words from subtitle (same normalization)
3. Extract all terms from keywords field (split on commas, lowercase, trim)
4. For multi-word keyword terms (e.g., "photo editor"), also extract individual words
5. Count total unique terms vs total terms
6. Calculate **dedup ratio**: unique terms / total terms

| Ratio | Grade |
|-------|-------|
| 100%  | A     |
| 90-99%| B     |
| 80-89%| C     |
| < 80% | F     |

7. **FAIL** if ratio < 80%

## Exceptions

- Connecting words in title/subtitle ("&", "-", "and") that also appear in keywords are acceptable since they serve a grammatical purpose in user-facing fields
- Your brand name in the title doesn't need to be "deduplicated" from other fields

## Fix

1. List all duplicated terms
2. For each duplicate, decide which field should keep it (title > subtitle > keywords)
3. Replace removed duplicates with new high-opportunity keywords
4. Run `aso keywords recommend` to find replacements
5. Re-check the dedup ratio after changes
