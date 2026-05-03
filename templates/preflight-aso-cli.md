# Preflight: ensure aso CLI is installed and logged in

Run this checklist before executing any `aso` command. If any check fails, resolve it and re-check before proceeding.

1. **CLI installed?** Run `command -v aso || echo "MISSING"`. If MISSING, instruct the user to install it:
   - Preferred: `brew install asomaniac/tap/aso`
   - Fallback: `curl -fsSL https://asomaniac.com/install.sh | sh`

   Then re-run the check before continuing.

2. **Authenticated to ASO Maniac?** Run `aso auth maniac status`. If it reports "no API key" or returns 401:
   - Run `aso auth maniac login`. This opens https://asomaniac.com/cli/auth in the browser.
   - Wait for the user to complete the OAuth flow before retrying any premium command.

3. **Auth error mid-skill?** If a premium command (`aso keywords ...`, `aso competitors ...`, `aso dashboard ...`, etc.) fails with `UNAUTHORIZED`, 401, or "Set ASO_MANIAC_API_KEY", repeat step 2 then retry the failing command.
