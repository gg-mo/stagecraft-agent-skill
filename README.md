# Stagecraft

A portable agent skill that turns coding agents into disciplined premium-UI designers. Dark, minimal, keynote-style output with refined motion, applicable across Claude Code, Copilot CLI, Cursor, Codex, and Gemini CLI.

Stagecraft is not a runtime library. It ships no npm package. The skill is a set of markdown files — an entry point (`SKILL.md`) plus progressive-disclosure references — that coding agents load and apply. Motion tokens, visual tokens, and reveal patterns come as copy-pasteable snippets the agent writes into your project.

## What it does

- Applies a keynote-style visual system (dark palette, disciplined type scale, 4px spacing grid) over UI work the agent is already doing.
- Applies seven named motion tokens with exact durations and easing curves, shipped as both React + Framer Motion variants and a CSS-only fallback.
- Picks one of five reveal patterns (scene-entry, focal-first, line-by-line, block-by-block, progressive-disclosure) per screen and avoids layering them.
- Runs a Mode C audit against eight dimensions for existing screens and returns a ranked diff, not a redesign.

## When to invoke

Trigger words: `premium`, `polished`, `cinematic`, `Apple-like`, `keynote`, `launch page`, `product reveal`, `elevate this screen`, `audit this UI`.

Skip it for: playful, gamified, maximalist, dense data tables, enterprise-density dashboards.

## Install

### Install — Claude Code

Stagecraft ships as a Claude Code plugin with an in-repo marketplace. Add the marketplace, then install the plugin:

```
/plugin marketplace add gg-mo/stagecraft-agent-skill
/plugin install stagecraft@stagecraft-agent-skill
```

Claude Code loads the plugin's `SKILL.md` automatically and pulls references on demand.

### Install — Copilot CLI

Copilot CLI reads the same skill format. Clone the repo and point it at the skill directory:

```
git clone https://github.com/gg-mo/stagecraft-agent-skill ~/.copilot/skills/stagecraft-src
ln -s ~/.copilot/skills/stagecraft-src/skills/stagecraft ~/.copilot/skills/stagecraft
```

### Install — Cursor

Copy the generated Cursor rule into your project:

```
mkdir -p .cursor/rules
cp path/to/stagecraft-agent-skill/integrations/cursor/stagecraft.mdc .cursor/rules/
```

Invoke with `@stagecraft` in chat.

### Install — Codex

Append the body of `integrations/codex/AGENTS.md` to your project's `AGENTS.md`:

```
cat path/to/stagecraft-agent-skill/integrations/codex/AGENTS.md >> AGENTS.md
```

Codex loads `AGENTS.md` automatically per project.

### Install — Gemini CLI

Same shape as Codex:

```
cat path/to/stagecraft-agent-skill/integrations/gemini/GEMINI.md >> GEMINI.md
```

## Using it

Ask the agent to build, restyle, or audit UI with any of the trigger words above. For example:

- "Turn this hero into a premium keynote-style reveal."
- "Audit this pricing section for Stagecraft."
- "Make this modal feel more polished."

The agent will consult `SKILL.md`, follow the 5-step workflow, and apply tokens from the references. For restyles, it runs the audit first and returns ranked changes.

## Repo layout

```
.claude-plugin/
  plugin.json                # Claude Code plugin manifest
  marketplace.json           # in-repo marketplace manifest
skills/stagecraft/
  SKILL.md                   # entry point (Claude Code / Copilot CLI read this)
  references/
    motion-tokens.md         # durations, easings, variants
    visual-system.md         # palette, type, spacing
    reveal-patterns.md       # five sequencing patterns
    audit-checklist.md       # Mode C critique flow
    examples/                # before/after transformations
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

Edit `SKILL.md` or files in `references/`. Then regenerate wrappers:

```
scripts/build-wrappers.sh
```

Never hand-edit files in `integrations/` — the script overwrites them.

## License

See [LICENSE](LICENSE).
