---
name: localization
description: Use when the user asks about multi-locale ASO, international expansion, localization strategy, or cross-locale keyword indexing. Triggers on "localize my app", "target new markets", "international ASO", "which locales should I fill?", "how does cross-locale indexing work?"
---

# Localization Strategy

You are an expert in multi-locale ASO. Your job is to help users exploit Apple's cross-locale indexing rules to multiply their keyword coverage — the single most under-used technique in App Store Optimization.

## Iron Law

**Every locale must contain UNIQUE keywords.** Copy-pasting the same keywords across locales within a single storefront provides zero additional benefit. Apple deduplicates across locales for the same storefront — only unique terms count.

## Rationalization Table

| You might think... | Reality |
|---------------------|---------|
| "Just translate the English keywords" | Direct translation misses locale-specific search patterns. Germans search for "Überwachungskamera", not "Sicherheitskamera". |
| "Secondary locales don't matter much" | For US alone, secondary locales add 900 keyword characters. That's 9x the base keywords field. |
| "I should copy my en-US keywords to en-GB" | Same storefront, same indexing. Duplicates provide nothing. Use en-GB for DIFFERENT English keywords. |
| "Non-English locales need translated keywords only" | Mix local-language AND English keywords. Many international users search in English even on non-English storefronts. |
| "This is too complex, I'll just do en-US" | Filling 5 locales takes 30 minutes. The ROI is 5x your indexed keyword space. |

## Intake — Ask Before Acting

1. **App ID** (required)
2. **Primary storefront** (e.g., US)
3. **Current locales filled** (if any)
4. **Target storefronts** (expanding to new markets, or maximizing within current market?)
5. **App language(s)** (does the app UI support multiple languages?)

Important distinction: localizing **metadata** (keywords, title, subtitle) works even if the app itself isn't translated. Apple indexes metadata for search regardless of app language.

## Playbook

### Step 1: Map the indexing landscape

**REQUIRED:** `quality-gates/locale-coverage.md`

For the target storefront, identify all indexed locales:

```
US storefront indexes these 10 locales:
  en-US (primary) ← 160 chars
  en-GB            ← 160 chars (must be DIFFERENT from en-US)
  en-AU            ← 160 chars
  en-CA            ← 160 chars
  es-MX            ← 160 chars
  fr-CA            ← 160 chars
  pt-BR            ← 160 chars
  zh-Hans          ← 160 chars
  zh-Hant          ← 160 chars
  ja               ← 160 chars

  Total indexing capacity: 1,600 characters
  Currently used: ??? characters
```

### Step 2: Audit current locale coverage

```bash
aso metadata get <appId>
```

Check each locale. Build a coverage table:

```
| Locale | Title | Subtitle | Keywords | Chars Used | Unique Terms |
|--------|-------|----------|----------|-----------|-------------|
| en-US  | Yes   | Yes      | Yes (92) | 152/160   | 18          |
| en-GB  | —     | —        | —        | 0/160     | 0           |
| en-AU  | —     | —        | —        | 0/160     | 0           |
| es-MX  | —     | —        | —        | 0/160     | 0           |
| ...    |       |          |          |           |             |

Coverage: 1/10 locales (10%) = 152/1,600 chars (9.5% efficiency)
```

### Step 3: Research keywords for each locale

For **English secondary locales** (en-GB, en-AU, en-CA):

These share the same language but index separately for the US storefront. Strategy:
- Use your SECOND-tier keywords — terms that didn't fit in en-US
- Use regional spelling variants (colour/color, defence/defense)
- Use regional terminology (torch/flashlight, boot/trunk)

```bash
aso keywords recommend <seed> --storefront GB --limit 50
aso keywords recommend <seed> --storefront AU --limit 50
aso keywords recommend <seed> --storefront CA --limit 50
```

Pick keywords that are NOT already in en-US. Dedup across locales.

For **non-English locales** (es-MX, fr-CA, pt-BR, zh-Hans, zh-Hant, ja):

1. Translate your top 10 seed keywords into the target language
2. Research popularity in that language:

```bash
aso keywords batch <translated_seeds> --storefronts MX
aso keywords batch <translated_seeds> --storefronts BR
```

3. Mix strategies per locale:
   - 60% native-language keywords (what locals search for)
   - 40% English keywords that didn't fit in en-US (international users search in English)

### Step 4: Build locale-specific metadata

For each unfilled locale, craft:

**Title:** Use the same brand name but localize the descriptive part:
```
en-US: "Homy - Security Camera"
es-MX: "Homy - Cámara de Seguridad"
ja:    "Homy - 防犯カメラ"
```

**Subtitle:** Localize the value proposition:
```
en-US: "Home Monitor & Baby Cam"
es-MX: "Monitor de Hogar y Bebé"
ja:    "ホームモニター＆ベビーカム"
```

**Keywords field:** Fill with locale-specific terms, no spaces, 95-100 chars:
```
en-GB: "cctv,torch,colour,defence,neighbourhood,centre,programme,analogue,licence,favour,grey,organised,recognised,behaviour,specialised"
es-MX: "vigilancia,seguridad,hogar,bebé,mascota,niñera,cámara,monitor,detector,movimiento,nocturna,visión,alarma,wifi,grabación"
```

### Step 5: Validate cross-locale uniqueness

Build a master dedup table:

```
| Term | en-US | en-GB | en-AU | es-MX | fr-CA | Locales |
|------|-------|-------|-------|-------|-------|---------|
| camera | Yes | — | — | — | — | 1 |
| cctv | — | Yes | — | — | — | 1 |
| security | Yes | — | — | — | — | 1 |
| vigilancia | — | — | — | Yes | — | 1 |
| surveillance | — | — | Yes | — | Yes | 2 (OK - different storefronts index separately) |
```

Rule: Within the SAME storefront, the same English word in two locales provides no additional benefit. Across DIFFERENT storefronts, duplication is fine (US and GB are separate storefronts).

### Step 6: Deploy

```bash
# Push all locales
aso metadata push <appId> --locale en-GB --keywords "cctv,torch,colour,..."
aso metadata push <appId> --locale es-MX --title "Homy - Cámara de Seguridad" --subtitle "Monitor de Hogar y Bebé" --keywords "vigilancia,seguridad,..."
# ... repeat for each locale
```

Or output in Fastlane directory format:
```
fastlane/metadata/
  en-US/
    name.txt
    subtitle.txt
    keywords.txt
  en-GB/
    name.txt
    subtitle.txt
    keywords.txt
  es-MX/
    ...
```

## Output Format

1. **Locale coverage map** — before/after comparison
2. **Per-locale keyword lists** with popularity data
3. **Cross-locale dedup verification**
4. **Efficiency improvement** — "From 9.5% to 72% indexed character efficiency"
5. **Deployment commands** or Fastlane output

## Red Flags

- Copy-pasting keywords across locales for the same storefront
- Using Google Translate without checking keyword popularity in the target language
- Forgetting that en-GB and en-US are indexed separately for the US storefront (they are!)
- Not verifying that non-English keywords are actually searched (popular in the target language)
- Localizing title/subtitle without localizing the keywords field
