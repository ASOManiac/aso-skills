# Fastlane Metadata Template

ASO skills can output optimized metadata in [Fastlane](https://fastlane.tools/) directory format for easy deployment via `fastlane deliver`.

## Directory structure

```
fastlane/metadata/
  en-US/
    name.txt          # App title (30 chars max)
    subtitle.txt      # App subtitle (30 chars max)
    keywords.txt      # Keywords field (100 chars max, comma-separated, no spaces)
    description.txt   # Full description (4000 chars max)
    release_notes.txt # What's New text (4000 chars max)
  en-GB/
    name.txt
    subtitle.txt
    keywords.txt
  es-MX/
    name.txt
    subtitle.txt
    keywords.txt
  # ... additional locales
```

## Usage

After running a metadata optimization skill:

```bash
# Option 1: Deploy via Fastlane
cd your-app-project
fastlane deliver --skip_binary_upload --skip_screenshots

# Option 2: Deploy via aso CLI
aso metadata push --app <appId> --version latest --dir ./fastlane/metadata

# Option 3: Manual — copy-paste from files into App Store Connect
```

## Important notes

- `keywords.txt` must have NO spaces after commas: `camera,security,home,baby`
- `name.txt` must be 30 characters or fewer
- `subtitle.txt` must be 30 characters or fewer
- Each locale directory name must match Apple's locale codes exactly
- Files must be UTF-8 encoded
