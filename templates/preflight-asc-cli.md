# Preflight: ensure fastlane and App Store Connect CLI are installed and authenticated

Run this checklist before pushing metadata, screenshots, or builds, or before pulling TestFlight feedback or crashes. Resolve any failure and re-check before proceeding.

## Tool selection rule

- **fastlane** is the **primary** tool for metadata, screenshots, builds, and submit.
- **App Store Connect CLI** (`asc` in code blocks) is the **fallback ONLY for TestFlight feedback and crashes** — gaps fastlane does not cover.

Do not reach for the App Store Connect CLI when fastlane can do the job.

## 1. fastlane installed?

```bash
command -v fastlane || echo "MISSING"
```

If MISSING, install (auto-install with user consent per the bootstrap policy):

- Preferred: `brew install fastlane`
- Fallback: `gem install fastlane` (requires Ruby ≥ 2.7 and Xcode command-line tools)

Re-run the check before continuing. On Windows, fastlane requires WSL or Ruby + DevKit; if the user is on Windows and not in WSL, stop and surface the limitation rather than fighting the install.

## 2. App Store Connect CLI installed?

Only required if the workflow needs TestFlight feedback or crashes.

```bash
command -v asc || echo "MISSING"
```

If MISSING:

- Preferred: `brew install rorkai/tap/asc`
- Fallback: install script from https://github.com/rorkai/App-Store-Connect-CLI

Re-run the check before continuing.

## 3. App Store Connect API key

Both tools authenticate with an App Store Connect API Key issued at https://appstoreconnect.apple.com/access/api. You need:

- The `.p8` private key file
- The Key ID
- The Issuer ID

### fastlane credentials

Store at `fastlane/api_key.json`:

```json
{
  "key_id": "ABCDE12345",
  "issuer_id": "11111111-2222-3333-4444-555555555555",
  "key": "-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----",
  "in_house": false
}
```

Then lock it down:

```bash
chmod 600 fastlane/api_key.json
```

Reference it in `Fastfile` via `app_store_connect_api_key(key_filepath: "fastlane/api_key.json")` or pass `api_key_path:` to `deliver` / `pilot`.

### App Store Connect CLI credentials

```bash
asc auth login
```

Follow the prompts to provide the `.p8` path, Key ID, and Issuer ID. Credentials are stored in the user's keychain.

## 4. Project initialized for fastlane?

```bash
test -d fastlane || echo "MISSING"
```

If MISSING, the user has not initialized fastlane in this repo. Run from the project root:

```bash
fastlane init
```

This is interactive — let the user choose the workflow (manage metadata / screenshots / beta / app store). Do not auto-pick.

## 5. Common failure modes

| Symptom | Likely cause | Fix |
|---|---|---|
| `command not found: fastlane` | Not installed or not on `PATH` | Install via Homebrew; restart shell |
| `command not found: asc` | App Store Connect CLI not installed | `brew install rorkai/tap/asc` |
| `401 Unauthorized` | Expired or revoked API key | Issue a new key at appstoreconnect.apple.com/access/api; update `fastlane/api_key.json` and re-run `asc auth login` |
| `No such app` / wrong team | Key issued for the wrong team or app filter | Verify Key Access (App Manager / Admin role) and `app_identifier` / `team_id` in `Appfile` |
| `403 Forbidden` from Apple endpoints | Network filter / corporate proxy stripping headers | Retry off VPN; check corporate proxy allow-list |
| Windows fastlane crashes | Native fastlane on Windows is unsupported | Run inside WSL2 |
| `ITMS-` errors during `deliver` | Metadata violates Apple guidelines | Read the message; fix the offending field; re-run |
