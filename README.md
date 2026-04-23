<div align="center">

# Stagecraft

**Keynote-style UI on demand.**

A portable agent skill that turns coding agents into disciplined premium-UI designers — dark, minimal, cinematic reveals with refined motion. One install, then ask any agent for a "premium" or "polished" screen and get composed output instead of noise.

[![Claude Code](https://img.shields.io/badge/Claude_Code-plugin-5A4BDD?logo=anthropic&logoColor=white)](https://code.claude.com/docs/en/plugins)
[![Cursor](https://img.shields.io/badge/Cursor-rule-000000?logo=cursor&logoColor=white)](#install--cursor)
[![Codex](https://img.shields.io/badge/Codex-AGENTS.md-10A37F?logo=openai&logoColor=white)](#install--codex)
[![Gemini CLI](https://img.shields.io/badge/Gemini_CLI-GEMINI.md-4285F4?logo=google&logoColor=white)](#install--gemini-cli)
[![Copilot CLI](https://img.shields.io/badge/Copilot_CLI-skill-24292E?logo=github&logoColor=white)](#install--copilot-cli)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![PRs welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](#contributing)

</div>

---

## What this is

Stagecraft is not a runtime library — it ships no npm package. It is a set of markdown files (`SKILL.md` + progressive-disclosure references) that coding agents load and apply. Motion tokens, visual tokens, and reveal patterns come as copy-pasteable snippets the agent writes into your project.

- **Visual system** — dark palette, disciplined type scale, 4px spacing grid, two shadow tiers, one accent color. No invented values.
- **Seven motion tokens** — named variants with exact durations and easing curves, shipped as React + Framer Motion *and* a CSS-only fallback.
- **Five reveal patterns** — scene-entry, focal-first, line-by-line, block-by-block, progressive-disclosure. Agents pick one per screen and don't layer them.
- **Audit checklist** — eight dimensions the agent scores existing screens against before declaring a restyle done.

## When to invoke

**Trigger words:** `premium`, `polished`, `cinematic`, `Apple-like`, `keynote`, `launch page`, `product reveal`, `elevate this screen`, `audit this UI`.

**Skip it for:** playful, gamified, maximalist, cartoonish surfaces; dense data tables; enterprise-density dashboards.

## Install

### Install — Claude Code

Stagecraft is a Claude Code plugin with an in-repo marketplace. One marketplace add, one plugin install:

```bash
/plugin marketplace add gg-mo/stagecraft-agent-skill
/plugin install stagecraft@stagecraft-agent-skill
```

Claude Code loads the plugin's `SKILL.md` automatically and pulls references on demand. To update:

```bash
/plugin marketplace update stagecraft-agent-skill
```

### Install — Cursor

Copy the generated Cursor rule into your project:

```bash
mkdir -p .cursor/rules
curl -L https://raw.githubusercontent.com/gg-mo/stagecraft-agent-skill/main/integrations/cursor/stagecraft.mdc \
  -o .cursor/rules/stagecraft.mdc
```

Invoke with `@stagecraft` in chat.

### Install — Codex

Append the inlined `AGENTS.md` body to your project's `AGENTS.md`:

```bash
curl -L https://raw.githubusercontent.com/gg-mo/stagecraft-agent-skill/main/integrations/codex/AGENTS.md >> AGENTS.md
```

Codex loads `AGENTS.md` automatically per project.

### Install — Gemini CLI

Same shape as Codex:

```bash
curl -L https://raw.githubusercontent.com/gg-mo/stagecraft-agent-skill/main/integrations/gemini/GEMINI.md >> GEMINI.md
```

### Install — Copilot CLI

Clone the repo and symlink the skill directory:

```bash
git clone https://github.com/gg-mo/stagecraft-agent-skill ~/.copilot/skills/stagecraft-src
ln -s ~/.copilot/skills/stagecraft-src/skills/stagecraft ~/.copilot/skills/stagecraft
```

## Using it

Ask the agent to build, restyle, or audit UI with any trigger word:

- *"Turn this hero into a premium keynote-style reveal."*
- *"Audit this pricing section for Stagecraft."*
- *"Make this modal feel more polished."*

The agent consults `SKILL.md`, follows the 5-step workflow, and applies tokens from the references. For restyles, it runs the audit first and returns a **ranked diff, not a redesign**.

## What's inside

| File | What it defines |
| --- | --- |
| [`skills/stagecraft/SKILL.md`](skills/stagecraft/SKILL.md) | Entry point — when to invoke, the 5-step workflow, the restraint bar |
| [`references/visual-system.md`](skills/stagecraft/references/visual-system.md) | Palette, type scale, spacing grid, radii, shadows |
| [`references/motion-tokens.md`](skills/stagecraft/references/motion-tokens.md) | 7 named variants + durations + easing curves + CSS fallback |
| [`references/reveal-patterns.md`](skills/stagecraft/references/reveal-patterns.md) | 5 sequencing patterns with "when to pick" guidance |
| [`references/audit-checklist.md`](skills/stagecraft/references/audit-checklist.md) | 8-dimension scorecard + red flags + output template |
| [`references/examples/`](skills/stagecraft/references/examples) | Before/after transformations (hero, modal, pricing card) |

## Repo layout

```
.claude-plugin/
  plugin.json                # Claude Code plugin manifest
  marketplace.json           # in-repo marketplace manifest
skills/stagecraft/
  SKILL.md                   # entry point
  references/                # progressive-disclosure details
    motion-tokens.md
    visual-system.md
    reveal-patterns.md
    audit-checklist.md
    examples/
integrations/                # generated wrappers (do not hand-edit)
  cursor/stagecraft.mdc
  codex/AGENTS.md
  gemini/GEMINI.md
scripts/
  build-wrappers.sh          # regenerates integrations/ from canonical sources
  wrapper-templates/         # framing for each non-native harness
  verify.sh                  # invariant checks
```

## Contributing

Edit `skills/stagecraft/SKILL.md` or files in `skills/stagecraft/references/`. Then regenerate the wrappers and verify invariants:

```bash
scripts/build-wrappers.sh
scripts/verify.sh
```

Never hand-edit files in `integrations/` — the build script overwrites them.

## License

[MIT](LICENSE).
