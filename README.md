# ASO Skills

Expert App Store Optimization playbooks for AI agents. Works with any AI coding assistant — Claude Code, Cursor, Codex, Gemini, Windsurf, and more.

## What is this?

ASO Skills teaches your AI agent how to do professional ASO. Each skill is a markdown playbook (`SKILL.md`) that guides your AI through keyword research, metadata optimization, competitor analysis, and more — using real App Store data from [ASO Maniac](https://asomaniac.com).

## Skills

| Skill | What it does |
|-------|-------------|
| **keyword-research** | Discover high-opportunity keywords using popularity/difficulty scoring |
| **metadata-optimizer** | Optimize title, subtitle, and keywords field with quality gates |
| **competitor-analysis** | Find keyword gaps and steal opportunities from competitors |
| **aso-audit** | Full ASO health check with A-F grading across all dimensions |
| **localization** | Multi-locale strategy leveraging cross-locale indexing rules |
| **rank-tracker** | Set up keyword rank monitoring with alerts |
| **release-notes** | Write keyword-optimized "What's New" text that reads naturally |
| **screenshot-text** | Craft screenshot captions that convert and rank |
| **ab-testing** | Design and measure metadata A/B tests |
| **keyword-cannibalization** | Fix keyword conflicts across multi-app portfolios |

## Quality Gates

Every metadata change passes through 11 quality gates — binary pass/fail rules based on how Apple's search algorithm actually works:

- **No keyword repetition** — never waste indexed characters on duplicates
- **Character utilization** — use 95%+ of available space
- **Singular forms** — Apple stems automatically, plurals waste characters
- **No stop words** — "the", "and", "for" waste keyword field space
- **No spaces after commas** — spaces count against the 100-char limit
- **No trademarked terms** — competitor brand names get you rejected
- **Locale coverage** — US indexes 10 locales = 1,600 characters of indexing
- **Natural language title** — titles must read like a product name, not a keyword list
- **Subtitle value prop** — subtitle communicates benefit, not just keywords
- **Cross-field dedup** — maximize unique indexed terms across all fields
- **Indexed character efficiency** — measure real utilization vs theoretical max

## Install

```bash
# Universal (works with any AI coding tool)
npx skills add ASOManiac/aso-skills

# Claude Code
claude plugin add ASOManiac/aso-skills

# Manual
git clone https://github.com/ASOManiac/aso-skills.git
cp -r aso-skills/skills/ ~/.claude/skills/aso/
```

## Prerequisites

Install and authenticate the ASO CLI:

```bash
brew install asomaniac/tap/aso
aso auth maniac login          # Browser OAuth (recommended)
# or: aso auth maniac login --api-key <KEY>
# or: export ASO_MANIAC_API_KEY=<KEY>
```

Or install via Go:

```bash
go install github.com/ASOManiac/aso-cli@latest
aso auth maniac login
```

## Self-Discovery

The CLI has two command families — skills must use the correct prefix:

| Family | Prefix | Examples |
|--------|--------|----------|
| App Store Connect (ASC) | `aso <cmd>` | `aso metadata pull`, `aso builds`, `aso apps`, `aso webhooks` |
| ASO Maniac (AI keywords) | `aso <cmd>` | `aso keywords`, `aso competitors`, `aso dashboard` |

When you don't know the exact flags or subcommands, **ask the CLI**:

```bash
aso --help                        # All top-level commands (intelligence commands listed first)
aso keywords --help               # Help for a specific command
aso schema <query>                # Machine-readable API endpoint discovery (for agents)
```

Prefer `--help` and `aso schema` over guessing. The CLI is the source of truth.

### Output Filtering

All intelligence commands support `--exclude` to strip verbose fields from JSON output:

```bash
aso keywords analyze camera --exclude topApps,relatedSearches   # Compact view
aso competitors 123456789 --exclude keywordOverlap              # Summary only
```

This is especially useful for AI agents to reduce token usage when verbose arrays like `topApps` aren't needed.

## Usage

Once installed, just ask your AI agent naturally:

```
"Research keywords for my fitness app targeting the US store"
"Optimize the metadata for app ID 123456789"
"Compare my app against competitor 987654321"
"Run a full ASO audit on my app"
"Help me localize for the German and Japanese stores"
```

Your AI agent will automatically activate the right skill and guide you through the process.

## How it works

```
You ask your AI agent about ASO
        |
        v
AI activates the matching SKILL.md playbook
        |
        v
Skill guides the AI step-by-step:
  1. Asks clarifying questions (app ID, storefront, goals)
  2. Runs aso CLI commands for real data
  3. Applies quality gates to validate
  4. Presents actionable recommendations
        |
        v
You review and apply changes
```

## Data source

Skills use the `aso` CLI which connects to [asomaniac.com](https://asomaniac.com) for real Apple Search Ads data:

- **Keyword popularity**: 5-100 scores from Apple Search Ads
- **Difficulty scoring**: Proprietary multi-signal algorithm
- **Competitor intelligence**: Cross-app keyword overlap analysis
- **Rank tracking**: Daily automated checks with historical trends

Free plan: 100 API calls/month. [Upgrade](https://asomaniac.com/pricing) for higher limits.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). We welcome new skills, quality gate improvements, and documentation fixes.

## License

MIT
