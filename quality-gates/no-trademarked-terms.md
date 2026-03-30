# Quality Gate: No Trademarked Terms

## Rule

NEVER include competitor brand names, trademarked product names, or protected terms in any metadata field (title, subtitle, keywords).

Common violations:
- Competitor app names (e.g., "Ring", "Nest", "Arlo" for a security camera app)
- Platform names used as keywords (e.g., "iPhone" in keywords — Apple prohibits this)
- Celebrity or character names
- Trademarked technology terms (e.g., "FaceTime", "AirDrop", "Siri")

## Why

1. **App Review rejection**: Apple will reject your update. This costs days of review cycle time and blocks your entire release pipeline.
2. **Legal risk**: Trademark holders can file takedown requests. Apple will remove your app without warning.
3. **Keyword instability**: Even if a trademarked term slips through review, Apple can de-index it at any time, causing sudden rank drops.

## How to check

1. Compile a list of competitor app names in your category
2. Check all three metadata fields against this list
3. Check against Apple's explicitly prohibited terms: "iPhone", "iPad", "Mac", "Apple", "App Store", "iOS", "macOS", "watchOS", "tvOS", "iPadOS", "Siri", "FaceTime", "AirDrop", "AirPlay", "iCloud"
4. Flag any term that is a proper noun or capitalized brand
5. **FAIL** if any trademarked term is found

## Exceptions

- Your own brand name in the title (required by Apple)
- Generic terms that happen to also be brand names IF the generic meaning is primary (e.g., "nest" as a bird's nest, not the Google product — but exercise extreme caution)
- Platform compatibility mentions in the description (NOT in title/subtitle/keywords): "Works with HomeKit" is allowed in the description

## Fix

1. Remove the trademarked term immediately
2. Replace with generic descriptors: "Ring" → "doorbell", "Nest" → "smart home", "Arlo" → "wireless camera"
3. Generic alternatives often have HIGHER search volume than the brand name anyway
4. Run `aso keywords analyze` on the generic alternative to confirm popularity
