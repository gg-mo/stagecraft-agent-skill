# Audit Checklist (Mode C)

Use when the user asks to "audit," "elevate," "refine," or "restyle" an existing screen. This is the critique-and-refactor flow.

## Input

Code, screenshot, or description of the existing screen. Ask for code if only a description is provided.

## Workflow

1. Score against the eight dimensions below. One-line `current → target` delta per dimension.
2. Rank the top three changes by visual-impact-per-edit.
3. Run the red-flag sweep and fold any hits into the ranked change list.
4. Apply the ranked changes using tokens from `motion-tokens.md` and `visual-system.md`.
5. Re-score. If any dimension is still below target, loop.

## Eight dimensions

For each dimension, record: `current state → target state`.

1. **Background and tone.** Is the surface on the Stagecraft palette (`sc-bg`, `sc-surface-*`)? Is it low-noise? Does it stop competing with content?
2. **Type discipline.** Are there five or fewer type-scale steps in use? Are weights limited to 400/500/600? Is hierarchy carried by scale, not thickness?
3. **Spacing and density.** Is spacing on the 4px grid? Is there real negative space around the focal region? Are gaps consistent?
4. **Alignment.** Is the composition anchored — centered or rigorously aligned? No scattered asymmetry without a clear reason?
5. **Emphasis restraint.** Is emphasis achieved through brightness, contrast, or single-pixel borders rather than glow, heavy shadow, or multi-color gradients?
6. **Motion coherence.** Does every transition use a token from `motion-tokens.md`? Is there one signature curve across the screen? Is exactly one reveal pattern active?
7. **Reveal sequencing.** Does the viewer encounter the focal region before supporting content? Are secondary controls deferred past primary-content readiness?
8. **Accessibility retained.** Are contrast ratios preserved (WCAG AA minimum for text)? Are focus states visible? Does `prefers-reduced-motion` degrade gracefully?

## Ranking rule

Sort candidate changes by **largest perceived-quality shift per line of code touched**. Global token swaps (palette, type scale) usually outrank local tweaks. Motion-pattern unification usually outranks individual-element tweaks.

## Red-flag sweep

Explicitly search the current screen for these anti-patterns and treat any hit as a forced change:

- Glow spam — box-shadow with blur > 60px, or glow on > 2 elements.
- Stacked gradients — more than one decorative gradient in the same viewport.
- Bouncy springs — any spring where stiffness > 160 or damping < 18.
- Scale pop on children — any list or grid where each child animates scale independently.
- Competing focal regions — two or more elements at the top of the visual hierarchy.
- Empty minimalism — centered layout with no type-scale hierarchy; "premium" via emptiness alone.
- Motion without intent — animations that run regardless of content significance.
- Accessibility regression — contrast dropped below WCAG AA, focus ring removed, or motion that blocks interaction for > 1 second.

## Output format

For every audit, produce exactly this structure:

```
### Observations
1. [dimension name]: [current] → [target]
2. ...

### Red flags
- [flag name] at [location]
- ...

### Ranked changes
1. [change] — [rationale, ≤15 words]
2. [change] — [rationale]
3. [change] — [rationale]

### Applied diff
(code diff here, using tokens from motion-tokens.md and visual-system.md)

### Re-score
- [any dimension still below target, or "all dimensions at target"]
```

Do not skip the re-score step; the audit is not complete until every dimension is at target or explicitly deferred with a reason.

## What not to do

- Do not rewrite the screen from scratch under the banner of "auditing." The audit is a targeted intervention, not a redesign.
- Do not change functional behavior (routes, data fetching, form logic) unless the user has asked for that.
- Do not remove accessibility features to achieve a minimal look.
