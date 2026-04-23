#!/usr/bin/env bash
# Stagecraft invariant checks. Run from repo root.
#
# Asserts:
#   - SKILL.md has valid frontmatter with name/description
#   - SKILL.md is under 100 lines
#   - All references in SKILL.md resolve
#   - No principle appears verbatim in more than one reference file
#   - Generated wrappers contain signature content from every reference

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

fail() { echo "FAIL: $1" >&2; exit 1; }

# 1. SKILL.md frontmatter + length
python3 -c "
import re, sys
c = open('SKILL.md').read()
m = re.match(r'^---\n(.*?)\n---', c, re.S)
assert m, 'no frontmatter'
body = m.group(1)
assert 'name: stagecraft' in body, 'missing name'
assert 'description:' in body, 'missing description'
" || fail "SKILL.md frontmatter invalid"

lines=$(wc -l < SKILL.md)
[ "$lines" -lt 100 ] || fail "SKILL.md is $lines lines (must be < 100)"

# 2. Referenced files resolve
for ref in $(grep -oE 'references/[a-z0-9/_-]+\.md' SKILL.md | sort -u); do
  [ -f "$ref" ] || fail "SKILL.md references missing file: $ref"
done

# 3. Duplicate-principle sentinel: check that some key principle phrases live
#    in exactly one file, not many.
check_unique() {
  local phrase="$1"
  local expected="$2"
  local count
  count=$(grep -lF "$phrase" SKILL.md references/*.md references/examples/*.md 2>/dev/null | wc -l | tr -d ' ')
  [ "$count" = "$expected" ] || fail "phrase '$phrase' appears in $count files (expected $expected)"
}
check_unique "eager to impress"         1   # only SKILL.md
check_unique "Eight dimensions"         1   # only audit-checklist.md
check_unique "ease-out-expo"            1   # only motion-tokens.md
check_unique "Five named sequencing"    1   # only reveal-patterns.md

# 4. Wrapper content check
for f in integrations/cursor/stagecraft.mdc integrations/codex/AGENTS.md integrations/gemini/GEMINI.md; do
  [ -f "$f" ] || fail "missing generated wrapper: $f"
  for needle in 'sceneEnter' '#0a0a0b' 'Eight dimensions' 'focal-first' '01-hero-section'; do
    grep -q "$needle" "$f" || fail "$f missing '$needle'"
  done
done

echo "all checks passed"
