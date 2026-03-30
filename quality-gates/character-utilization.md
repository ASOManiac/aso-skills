# Quality Gate: Character Utilization

## Rule

- **Title**: Use 25-30 of 30 characters (83-100%)
- **Subtitle**: Use 25-30 of 30 characters (83-100%)
- **Keywords field**: Use 95-100 of 100 characters (95-100%)

## Why

Every unused character is a missed keyword opportunity. Apple gives you exactly 160 characters across three fields to tell its algorithm what your app does. Leaving 20 characters empty in the keywords field means 2-3 keywords you're not ranking for.

The title and subtitle have slightly more flexibility because they serve a dual purpose: ranking AND conversion. A 22-character title that reads well may outperform a 30-character title that looks stuffed. But the keywords field is invisible to users — fill it to the brim.

## How to check

1. Count characters in title (including spaces, excluding app name separator if applicable)
2. Count characters in subtitle
3. Count characters in keywords field (commas count, spaces after commas should NOT exist)
4. **WARN** if title < 25 chars
5. **WARN** if subtitle < 25 chars
6. **FAIL** if keywords field < 95 chars

## Scoring

| Utilization | Grade |
|-------------|-------|
| 95-100%     | A     |
| 85-94%      | B     |
| 75-84%      | C     |
| < 75%       | F     |

## Exceptions

- Title: If your brand name + core keyword naturally fall under 25 chars and adding more would feel forced, 20+ chars is acceptable
- Keywords field: No exceptions. You should always be able to fill 95+ characters with valuable keywords

## Fix

1. Run `aso keywords recommend <current_top_keyword> --limit 50` to find more keywords
2. Sort by opportunity score (popularity * (100 - difficulty) / 100)
3. Add the highest-opportunity keywords until you hit the character limit
4. Remember: no spaces after commas in the keywords field (they count against the limit)
