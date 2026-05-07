# Quality gates index

Binary pass/fail rules for App Store metadata. Each gate is one rule with a check, rationale, and fix.

| Gate | Purpose |
|---|---|
| [no-keyword-repetition](no-keyword-repetition.md) | Each word lives in exactly one of title / subtitle / keywords — never duplicated across fields. |
| [character-utilization](character-utilization.md) | Use 95-100% of the keywords field and 80%+ of title / subtitle — every empty character is a missed keyword. |
| [singular-forms](singular-forms.md) | Use singular keywords only; Apple stems automatically and plurals waste a character each. |
| [no-stop-words](no-stop-words.md) | Strip "the", "and", "for", etc. from the keywords field — Apple ignores them in matching. |
| [no-spaces-after-commas](no-spaces-after-commas.md) | Comma-separate keywords with no spaces; spaces count against the 100-character limit. |
| [no-trademarked-terms](no-trademarked-terms.md) | Never include competitor / platform / trademarked names — App Review rejects, Apple de-indexes, lawyers strike. |
| [natural-language-title](natural-language-title.md) | Title must read as `Brand - Phrase`, not a keyword dump — readability drives conversion. |
| [subtitle-value-prop](subtitle-value-prop.md) | Subtitle communicates a user benefit, not just a second keyword field. |
| [cross-field-dedup](cross-field-dedup.md) | Aggregate dedup metric — count unique indexed terms across title + subtitle + keywords. |
| [locale-coverage](locale-coverage.md) | Fill all locales Apple indexes for the storefront (10 for US) — 1,600 characters of indexing capacity. |
| [indexed-char-efficiency](indexed-char-efficiency.md) | Master metric — unique indexed characters / total available across all filled locales. |

When invoking gates from skills, link this index instead of repeating gate names inline.
