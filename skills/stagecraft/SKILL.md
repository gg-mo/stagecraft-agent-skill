---
name: stagecraft
description: Use when the user wants premium, keynote-style UI with refined motion — dark, minimal, cinematic reveals. Trigger words include "premium," "polished," "cinematic," "Apple-like," "keynote," "launch page," "product reveal," and "elevate this screen." Also use when asked to audit or restyle an existing screen to feel more restrained and intentional.
---

# Stagecraft

Turn an interface into a premium, keynote-style experience — minimalist, restrained, high-tech — without sacrificing clarity, functionality, accessibility, or responsiveness.

Do not just make the UI "fancier." Make it feel more intentional, more coherent, and more expensive.

## When to use

Invoke Stagecraft when the user wants UI that feels: premium, polished, keynote-style, Apple-like, cinematic, modern, minimal, elegant, launch-ready, high-end SaaS, or dramatic in a controlled way. Typical surfaces: landing pages, hero sections, onboarding flows, result pages, premium dashboards, product-reveal screens, AI answer interfaces, modals, loading states, pricing sections, showcase pages.

Also invoke when the user says "audit," "elevate," "refine," or "make this feel more premium" about an existing screen — run the audit flow in `references/audit-checklist.md`.

## When not to use

Skip Stagecraft when the requested interface should feel playful, cute, gamified, youthful, expressive, maximalist, cartoonish, neon-heavy, or intentionally quirky. Apply cautiously to dense productivity tables, enterprise data-heavy surfaces, or workflows where minimal motion is important and content density outweighs stage presence.

## Workflow

1. **Identify UI intent.** Name what the screen is for, what must remain visible and usable, and what the primary focal region should be. Write this down in one or two sentences before touching styling.
2. **Apply the visual system.** Load `references/visual-system.md` and use its palette, type scale, spacing grid, radius, and shadow tokens. Do not invent values.
3. **Apply motion tokens.** Load `references/motion-tokens.md` and use the named variants (`sceneEnter`, `fadeUp`, `fadeIn`, `modalIn`, `scaleSettle`, `sceneExit`, `staggerContainer`, `staggerBlock`). Do not invent durations or easing curves.
4. **Apply reveal sequencing.** Load `references/reveal-patterns.md` and pick one of the five patterns (scene-entry, focal-first, line-by-line, block-by-block, progressive-disclosure). Do not combine more than one primary pattern within a single element tree.
5. **Run the audit.** Load `references/audit-checklist.md` and score the output against eight dimensions before declaring done. Fix any dimension that is not at target.

When the task is a restyle of existing UI, start at step 5 (audit first), then apply steps 2–4 as the ranked changes dictate.

## The restraint bar

Premium does not mean more effects. It means fewer, stronger decisions. Remove noise before adding emphasis. Keep one to two dominant focal regions per screen. If the result feels eager to impress, it is probably too much. If it feels inevitable, composed, and expensive, it is correct.

If design tension arises between "cool" and "usable," choose usable. Motion must never delay basic comprehension; accessibility states (focus, contrast, keyboard navigation) are never sacrificed for style.
