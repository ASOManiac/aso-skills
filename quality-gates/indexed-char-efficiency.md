# Quality Gate: Indexed Character Efficiency

## Rule

Measure and maximize the ratio of **unique indexed characters** to **total available characters** across all filled locales.

```
Efficiency = (unique keyword characters used) / (total keyword characters available) * 100
```

Target: **90%+ efficiency** for the primary locale, **70%+ across all indexed locales**.

## Why

This is the master metric that combines character utilization, cross-field dedup, and locale coverage into a single score. It answers: "What percentage of Apple's indexing capacity are you actually using?"

Most apps score 10-15% efficiency because they only fill en-US keywords and repeat terms across fields. An app scoring 80%+ has a massive structural advantage — they're competing with 5-10x more indexed terms.

## How to check

### Per-locale efficiency

1. Count unique indexable words across title + subtitle + keywords (after dedup)
2. Count total characters used across all three fields
3. Count total characters available (30 + 30 + 100 = 160)
4. Efficiency = characters used / 160

### Cross-locale efficiency (the real metric)

1. For the target storefront, identify all indexed locales
2. For each locale, count unique keywords NOT already present in other locales
3. Total unique characters = sum of genuinely new characters per locale
4. Total available = 160 * number of indexed locales
5. Efficiency = total unique characters / total available

### Scoring

| Efficiency | Grade | Interpretation |
|------------|-------|---------------|
| 90-100%    | A     | Exceptional — near-maximum indexing capacity |
| 70-89%     | B     | Good — room for improvement in secondary locales |
| 50-69%     | C     | Average — significant untapped potential |
| 30-49%     | D     | Below average — missing easy wins |
| < 30%      | F     | Critical — likely only primary locale filled |

## Exceptions

- New apps that haven't had time to research keywords for all locales get a grace period
- Apps targeting a single non-English market may legitimately have lower cross-locale efficiency

## Fix

1. Start with the biggest gap: if only primary locale is filled, that's the #1 fix
2. Within each locale: apply character-utilization gate (fill to 95%+ in keywords field)
3. Across locales: ensure each locale adds UNIQUE keywords (no copy-paste from primary)
4. Across fields: apply cross-field-dedup gate
5. Re-measure after each round of changes
