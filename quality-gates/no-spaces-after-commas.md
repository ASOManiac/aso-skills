# Quality Gate: No Spaces After Commas

## Rule

The keywords field MUST use commas with **no spaces** as separators.

```
CORRECT: camera,security,home,baby,monitor,surveillance,pet,nanny,wifi,motion
WRONG:   camera, security, home, baby, monitor, surveillance, pet, nanny, wifi, motion
```

## Why

Spaces count against the 100-character limit. In the wrong example above, 9 unnecessary spaces waste 9 characters — enough for "detect,alert" (12 chars) or similar valuable keywords.

Apple strips leading/trailing whitespace from each keyword term during indexing, so `camera` and ` camera` are indexed identically. The space does nothing except consume your budget.

## How to check

1. Scan the keywords field string for `, ` (comma followed by space)
2. Also check for ` ,` (space before comma) — less common but equally wasteful
3. Check for leading or trailing spaces in the entire field
4. **FAIL** if any space is found adjacent to a comma or at field boundaries

## Exceptions

None. There is never a reason to include spaces in the keywords field.

## Fix

1. Find and replace: `, ` → `,`
2. Find and replace: ` ,` → `,`
3. Trim leading/trailing whitespace
4. Use the recovered characters for new keywords
