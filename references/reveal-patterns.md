# Reveal Patterns

Five named sequencing patterns. Pick exactly one primary pattern per element tree; do not nest patterns inside each other (nesting produces theatrical, overlong intros).

All snippets assume variants from `motion-tokens.md` have been imported from `src/lib/stagecraft-motion`.

## 1. scene-entry

**Use when:** the viewer is landing on a screen for the first time. Establishes the stage before anything else animates.

**Behavior:** root fades in (`sceneEnter`), then children enter with `fadeUp` via `staggerContainer`.

```tsx
import { motion } from "framer-motion";
import { sceneEnter, staggerContainer, fadeUp } from "@/lib/stagecraft-motion";

export function Scene({ children }: { children: React.ReactNode }) {
  return (
    <motion.main
      variants={sceneEnter}
      initial="initial"
      animate="animate"
      className="min-h-screen bg-sc-bg text-sc-text"
    >
      <motion.div
        variants={staggerContainer}
        initial="initial"
        animate="animate"
      >
        {children}
      </motion.div>
    </motion.main>
  );
}

// Consumers:
<Scene>
  <motion.h1 variants={fadeUp}>Title</motion.h1>
  <motion.p  variants={fadeUp}>Subtitle copy.</motion.p>
</Scene>
```

**Do not combine with:** `focal-first` at the same root. Pick one.

## 2. focal-first

**Use when:** a single element (title, hero visual, headline metric) is the undisputed focal moment and everything else is supporting.

**Behavior:** focal element lands via `fadeUp` at t=0. Supporting content enters as a staggered block starting 200ms later.

```tsx
import { motion } from "framer-motion";
import { fadeUp, staggerContainer } from "@/lib/stagecraft-motion";

export function FocalScene() {
  return (
    <>
      <motion.h1
        variants={fadeUp}
        initial="initial"
        animate="animate"
        className="text-sc-display font-sc-sans"
      >
        Product reveal
      </motion.h1>

      <motion.div
        variants={{
          initial: {},
          animate: { transition: { delayChildren: 0.2, staggerChildren: 0.1 } },
        }}
        initial="initial"
        animate="animate"
      >
        <motion.p variants={fadeUp}>Supporting copy line one.</motion.p>
        <motion.p variants={fadeUp}>Supporting copy line two.</motion.p>
        <motion.div variants={fadeUp}>
          <button>Primary action</button>
        </motion.div>
      </motion.div>
    </>
  );
}
```

**Do not combine with:** `line-by-line` on the focal element itself. The focal element lands as one unit.

## 3. line-by-line

**Use when:** revealing a significant block of prose — a manifesto, a long headline broken across multiple lines, a reveal narration.

**Behavior:** each line fades up with 80ms stagger.

```tsx
import { motion } from "framer-motion";
import { fadeUp, staggerContainer } from "@/lib/stagecraft-motion";

export function LineReveal({ lines }: { lines: string[] }) {
  return (
    <motion.div
      variants={staggerContainer}
      initial="initial"
      animate="animate"
      className="text-sc-title font-sc-sans"
    >
      {lines.map((line, i) => (
        <motion.span
          key={i}
          variants={fadeUp}
          style={{ display: "block" }}
        >
          {line}
        </motion.span>
      ))}
    </motion.div>
  );
}
```

**Do not combine with:** `focal-first` inside the same paragraph, and do not apply to body paragraphs longer than ~6 lines — it becomes theatrical and delays reading.

## 4. block-by-block

**Use when:** a page has multiple distinct sections (hero, features, testimonial, CTA) that should feel like separate acts.

**Behavior:** each section enters as a unit with 120ms stagger (`staggerBlock`).

```tsx
import { motion } from "framer-motion";
import { staggerBlock, fadeUp } from "@/lib/stagecraft-motion";

export function BlockSequence({ sections }: { sections: React.ReactNode[] }) {
  return (
    <motion.div
      variants={staggerBlock}
      initial="initial"
      animate="animate"
    >
      {sections.map((section, i) => (
        <motion.section key={i} variants={fadeUp}>
          {section}
        </motion.section>
      ))}
    </motion.div>
  );
}
```

For scroll-triggered reveal of distant sections, swap `animate="animate"` for `whileInView="animate"` and set `viewport={{ once: true, amount: 0.3 }}`.

**Do not combine with:** per-section scene-entry. The page-level sequence owns the stage.

## 5. progressive-disclosure

**Use when:** primary content should be interactive immediately, and secondary controls should appear only after the primary content settles.

**Behavior:** primary content uses `sceneEnter` or `fadeUp`. Secondary controls fade in via `fadeIn` after `onAnimationComplete`.

```tsx
import { useState } from "react";
import { AnimatePresence, motion } from "framer-motion";
import { sceneEnter, fadeIn } from "@/lib/stagecraft-motion";

export function Screen({ primary, secondary }: {
  primary: React.ReactNode;
  secondary: React.ReactNode;
}) {
  const [primaryReady, setPrimaryReady] = useState(false);

  return (
    <>
      <motion.div
        variants={sceneEnter}
        initial="initial"
        animate="animate"
        onAnimationComplete={() => setPrimaryReady(true)}
      >
        {primary}
      </motion.div>

      <AnimatePresence>
        {primaryReady && (
          <motion.div
            variants={fadeIn}
            initial="initial"
            animate="animate"
            exit={{ opacity: 0 }}
          >
            {secondary}
          </motion.div>
        )}
      </AnimatePresence>
    </>
  );
}
```

**Do not combine with:** delays that total more than ~1.0s before the first interactive control is visible. Usability beats cinema.

## Choosing a pattern

| Intent | Use |
|---|---|
| Fresh page load, no dominant element | `scene-entry` |
| One hero element, supporting content | `focal-first` |
| Manifesto / multi-line headline / narrated reveal | `line-by-line` |
| Multi-section marketing page | `block-by-block` |
| Interactive surface where secondary UI can wait | `progressive-disclosure` |

## Anti-patterns

- Nesting patterns inside each other (e.g. `focal-first` inside a child of `scene-entry` that is itself inside `block-by-block`).
- Applying the same pattern twice at different levels of the tree (e.g. `scene-entry` at the app root and again at the page root).
- Using `line-by-line` on body copy longer than a paragraph — viewers want to read, not watch.
- Secondary controls gated behind animations longer than 1 second.
