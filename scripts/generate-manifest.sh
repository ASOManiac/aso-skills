#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
OUTPUT="$PROJECT_DIR/manifest.json"

echo "Generating skills manifest..."

# Read skill frontmatter and build JSON
SKILLS_JSON="["
FIRST=true
for skill_dir in "$PROJECT_DIR"/skills/*/; do
  skill_file="$skill_dir/SKILL.md"
  [ -f "$skill_file" ] || continue

  name=$(basename "$skill_dir")
  # Extract description from frontmatter
  description=$(awk '/^---$/{n++; next} n==1 && /^description:/{sub(/^description: */, ""); gsub(/^"|"$/, ""); print; exit}' "$skill_file")

  if [ -z "$description" ]; then
    description="$name skill"
  fi

  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    SKILLS_JSON+=","
  fi
  SKILLS_JSON+=$(printf '\n    {"name": "%s", "description": "%s"}' "$name" "$description")
done
SKILLS_JSON+="\n  ]"

# Build quality gates array
GATES_JSON="["
FIRST=true
for gate_file in "$PROJECT_DIR"/quality-gates/*.md; do
  [ -f "$gate_file" ] || continue
  gate_name=$(awk '/^# /{sub(/^# /, ""); print; exit}' "$gate_file")
  [ -z "$gate_name" ] && gate_name=$(basename "$gate_file" .md | tr '-' ' ')

  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    GATES_JSON+=","
  fi
  GATES_JSON+=$(printf '\n    "%s"' "$gate_name")
done
GATES_JSON+="\n  ]"

cat > "$OUTPUT" << MANIFEST
{
  "version": "1.0.0",
  "install": {
    "universal": "npx skills add ASOManiac/aso-skills",
    "claude": "claude plugin add ASOManiac/aso-skills",
    "manual": "git clone https://github.com/ASOManiac/aso-skills.git"
  },
  "skills": $(echo -e "$SKILLS_JSON"),
  "qualityGates": $(echo -e "$GATES_JSON")
}
MANIFEST

echo "Generated $OUTPUT"
