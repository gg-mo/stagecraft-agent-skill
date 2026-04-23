#!/usr/bin/env bash
# Regenerates integrations/ wrappers from canonical SKILL.md + references/.
# Wrappers are inlined copies (Cursor, Codex, Gemini don't do progressive disclosure
# the same way Claude Code does).
#
# Usage: scripts/build-wrappers.sh
# Run from repo root.

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

SKILL_DIR="skills/stagecraft"
SKILL_FILE="$SKILL_DIR/SKILL.md"

if [ ! -f "$SKILL_FILE" ]; then
  echo "error: run from repo root ($SKILL_FILE not found)" >&2
  exit 1
fi

OUT_CURSOR="integrations/cursor/stagecraft.mdc"
OUT_CODEX="integrations/codex/AGENTS.md"
OUT_GEMINI="integrations/gemini/GEMINI.md"

mkdir -p "$(dirname "$OUT_CURSOR")" "$(dirname "$OUT_CODEX")" "$(dirname "$OUT_GEMINI")"

# Strip the frontmatter block from SKILL.md for inlining into wrappers that
# carry their own frontmatter (Cursor) or don't use frontmatter (Codex, Gemini).
strip_frontmatter() {
  awk 'BEGIN{in_fm=0; done=0} /^---$/ && !done { in_fm=!in_fm; if (!in_fm) done=1; next } !in_fm && done { print }' "$1"
}

SKILL_BODY="$(strip_frontmatter "$SKILL_FILE")"

append_references() {
  for f in \
    "$SKILL_DIR/references/visual-system.md" \
    "$SKILL_DIR/references/motion-tokens.md" \
    "$SKILL_DIR/references/reveal-patterns.md" \
    "$SKILL_DIR/references/audit-checklist.md" \
    "$SKILL_DIR/references/examples/01-hero-section.md" \
    "$SKILL_DIR/references/examples/02-modal.md" \
    "$SKILL_DIR/references/examples/03-pricing-card.md"
  do
    echo ""
    echo "---"
    echo ""
    echo "# [inlined] $f"
    echo ""
    cat "$f"
  done
}

# Cursor: head template already contains MDC frontmatter. Append body + references.
{
  cat scripts/wrapper-templates/cursor.head.mdc
  echo "$SKILL_BODY"
  append_references
} > "$OUT_CURSOR"

# Codex: head template + body + references.
{
  cat scripts/wrapper-templates/codex.head.md
  echo "$SKILL_BODY"
  append_references
} > "$OUT_CODEX"

# Gemini: same shape as Codex.
{
  cat scripts/wrapper-templates/gemini.head.md
  echo "$SKILL_BODY"
  append_references
} > "$OUT_GEMINI"

echo "built:"
echo "  $OUT_CURSOR ($(wc -l < "$OUT_CURSOR") lines)"
echo "  $OUT_CODEX ($(wc -l < "$OUT_CODEX") lines)"
echo "  $OUT_GEMINI ($(wc -l < "$OUT_GEMINI") lines)"
