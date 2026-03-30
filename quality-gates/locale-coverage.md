# Quality Gate: Locale Coverage

## Rule

Apps targeting the US App Store MUST fill metadata for all locales that Apple indexes for US search results. At minimum, fill these 10 locales:

| Locale | Why indexed for US |
|--------|-------------------|
| en-US | Primary |
| en-GB | English variant |
| en-AU | English variant |
| en-CA | English variant |
| es-MX | Large US Hispanic population |
| fr-CA | Canadian French |
| pt-BR | Portuguese speakers in US |
| zh-Hans | Chinese speakers in US |
| zh-Hant | Traditional Chinese speakers |
| ja | Japanese speakers in US |

## Why

This is the single most under-exploited ASO technique. Apple indexes **all locale metadata** for a given storefront. A US user searching for "camera" will match against your en-US keywords, your es-MX keywords, your ja keywords — all of them.

This means a US-targeted app has not 100 characters of keyword space, but **1,600 characters** (100 chars x 10 indexed locales + title/subtitle chars). Most competitors only fill en-US, leaving 90% of their indexing capacity unused.

### Character math

| Locales filled | Keyword chars | Title+Subtitle chars | Total indexed |
|---------------|---------------|---------------------|---------------|
| 1 (en-US only) | 100 | 60 | 160 |
| 5 locales | 500 | 300 | 800 |
| 10 locales | 1,000 | 600 | 1,600 |

## How to check

1. For the target storefront, identify all indexed locales (US = 10, GB = 5, DE = 3, etc.)
2. Check which locales have metadata filled
3. For filled locales, check that keywords are DIFFERENT from the primary locale (repeating the same keywords across locales provides no benefit within the same storefront)
4. **WARN** if < 50% of indexed locales are filled
5. **FAIL** if only the primary locale is filled

### Storefront indexing rules (key markets)

| Storefront | Indexed locales | Total keyword chars |
|-----------|----------------|-------------------|
| US | en-US, en-GB, en-AU, en-CA, es-MX, fr-CA, pt-BR, zh-Hans, zh-Hant, ja | 1,600 |
| GB | en-GB, en-US, en-AU | 480 |
| DE | de-DE, en-US, en-GB | 480 |
| JP | ja, en-US | 320 |
| FR | fr-FR, en-US | 320 |
| BR | pt-BR, en-US | 320 |

## Exceptions

- Non-English locales can use English keywords in secondary locale slots if the app's audience in that storefront primarily searches in English
- If the app is only relevant to one language group, focusing on fewer locales is acceptable

## Fix

1. Identify unfilled locales with `aso metadata pull --app <appId> --version latest --dir ./metadata`
2. For each unfilled locale, generate locale-appropriate keywords:
   - Use `aso keywords batch <seeds> --storefronts <locale_storefront>`
   - For non-English locales: translate your top keywords and check their popularity
3. Ensure keywords in secondary locales are DIFFERENT from primary locale keywords (no duplication benefit within the same storefront)
4. Deploy with `aso metadata push --app <appId> --version latest --dir ./metadata` or Fastlane
