# Example 1 — Hero section

A generic SaaS hero elevated to keynote style. Demonstrates `sceneEnter` + `focal-first`, type-scale rework, removal of a decorative gradient, and palette migration.

## Before

```tsx
export function Hero() {
  return (
    <section className="relative bg-gradient-to-br from-indigo-600 via-purple-500 to-pink-500 text-white min-h-[80vh] flex items-center justify-center">
      <div className="absolute inset-0 bg-black/20" />
      <div className="relative text-center max-w-3xl px-6">
        <p className="uppercase tracking-widest text-xs font-bold mb-4">Introducing</p>
        <h1 className="text-5xl md:text-7xl font-extrabold mb-6 drop-shadow-lg">
          The future of shipping software
        </h1>
        <p className="text-lg md:text-xl mb-8 opacity-90">
          Build, deploy, and scale with confidence using our all-in-one platform.
        </p>
        <div className="flex gap-4 justify-center">
          <button className="bg-white text-black px-8 py-3 rounded-full font-bold shadow-xl hover:scale-105 transition">
            Start free trial
          </button>
          <button className="border-2 border-white text-white px-8 py-3 rounded-full font-bold hover:bg-white/10">
            Watch demo
          </button>
        </div>
      </div>
    </section>
  );
}
```

## Audit findings

1. **Background and tone.** Multi-color gradient competes with content. Not on Stagecraft palette. `current → target`: replace with `sc-bg`.
2. **Type discipline.** Uses `font-extrabold` (800). `current → target`: drop to 500 weight, carry hierarchy through scale.
3. **Emphasis restraint.** `drop-shadow-lg` on title + `shadow-xl` on CTA + hover `scale-105` stack three loud emphasis methods. `current → target`: remove shadows, remove scale hover, use `fadeUp` entrance instead.
4. **Motion coherence.** No motion tokens; hover scale is the only transition and it is unstructured. `current → target`: apply `sceneEnter` + `focal-first`.
5. **Reveal sequencing.** All content appears at once. `current → target`: title lands first, supporting copy + CTAs stagger 200ms after.

**Red flags:** glow spam (two shadows + one drop-shadow), stacked gradient, bouncy hover (`scale-105`).

## Ranked changes

1. Palette + background swap — removes the loudest noise source with one diff.
2. Type rework — drop to sc-display / sc-body, weight 500/400.
3. Motion + reveal — add `focal-first` sequencing; remove hover scale.

## After

```tsx
import { motion } from "framer-motion";
import { fadeUp } from "@/lib/stagecraft-motion";

export function Hero() {
  return (
    <section className="bg-sc-bg text-sc-text min-h-[80vh] flex items-center justify-center font-sc-sans">
      <div className="text-center max-w-3xl px-sc-6">
        <motion.p
          variants={fadeUp}
          initial="initial"
          animate="animate"
          className="text-sc-caption text-sc-text-secondary mb-sc-4 tracking-wide"
        >
          Introducing
        </motion.p>

        <motion.h1
          variants={fadeUp}
          initial="initial"
          animate="animate"
          className="text-sc-display font-medium mb-sc-6"
        >
          The future of shipping software
        </motion.h1>

        <motion.div
          variants={{
            animate: { transition: { delayChildren: 0.2, staggerChildren: 0.08 } },
          }}
          initial="initial"
          animate="animate"
        >
          <motion.p
            variants={fadeUp}
            className="text-sc-body text-sc-text-secondary mb-sc-8 max-w-xl mx-auto"
          >
            Build, deploy, and scale with confidence.
          </motion.p>

          <motion.div variants={fadeUp} className="flex gap-sc-4 justify-center">
            <button className="bg-sc-accent-neutral text-sc-bg px-sc-6 py-sc-3 rounded-sc-md text-sc-body font-medium transition-colors hover:bg-sc-text">
              Start free trial
            </button>
            <button className="border border-sc-border text-sc-text px-sc-6 py-sc-3 rounded-sc-md text-sc-body font-medium transition-colors hover:bg-sc-surface-1">
              Watch demo
            </button>
          </motion.div>
        </motion.div>
      </div>
    </section>
  );
}
```

## What we deliberately did not change

- Copy length. The hero's words remain identical. Stagecraft changes feel, not meaning.
- Layout (centered). A centered hero is already on-brand for this pattern; we did not force asymmetry.
- CTA count. Two CTAs are reasonable; Stagecraft does not mandate reduction for its own sake.
- Button shapes. We kept rounded rectangles rather than switching to pills; consistency with the radius token is enough.

## Re-score

All eight dimensions at target: palette on-system, type disciplined (two scale steps + one caption, weights 400/500), spacing on grid, alignment centered with clear anchor, emphasis carried by focal-first motion only, single motion pattern, sequencing leads with title, accessibility retained (contrast passes, focus rings via default button styling, `prefers-reduced-motion` honored by the CSS fallback if Framer is unavailable).
