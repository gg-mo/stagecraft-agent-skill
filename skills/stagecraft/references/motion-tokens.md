# Motion Tokens

These are the only motion values Stagecraft uses. Do not invent new durations, easings, or transforms. Pick the token that matches the intent; if none fit, pick the closest and keep the intent tight.

## Token table

| Token | Duration | Easing | Transform | Use |
|---|---|---|---|---|
| `sceneEnter` | 0.8s | `cubic-bezier(0.22, 1, 0.36, 1)` | opacity 0 → 1 | page/scene open |
| `fadeUp` | 0.6s | `cubic-bezier(0.22, 1, 0.36, 1)` | y 16px → 0, opacity 0 → 1 | default entrance for content |
| `fadeIn` | 0.5s | `cubic-bezier(0.4, 0, 0.2, 1)` | opacity only | chrome, secondary UI |
| `modalIn` | 0.5s | `cubic-bezier(0.22, 1, 0.36, 1)` | y 8px → 0, opacity 0 → 1 | overlays, popovers, dialogs |
| `scaleSettle` | 0.5s | `cubic-bezier(0.22, 1, 0.36, 1)` | scale 0.98 → 1, opacity 0 → 1 | rare focal emphasis |
| `sceneExit` | 0.45s | `cubic-bezier(0.4, 0, 1, 1)` | opacity 1 → 0 | cross-scene, dismiss |
| `stagger` | — | — | 0.08s between children (0.12s for heavier blocks) | orchestrator |

`cubic-bezier(0.22, 1, 0.36, 1)` is the signature curve — ease-out-expo, "silky settle." Use it for all content entrances. Exit easing uses `cubic-bezier(0.4, 0, 1, 1)` so dismissals feel brisk without snapping.

## React + Framer Motion

Copy this object into the project (e.g. `src/lib/stagecraft-motion.ts`) and import named variants. Do not re-tune values per component.

```tsx
import type { Variants } from "framer-motion";

const easeOutSoft = [0.22, 1, 0.36, 1] as const;
const easeInOutSoft = [0.4, 0, 0.2, 1] as const;
const easeOutLinear = [0.4, 0, 1, 1] as const;

export const sceneEnter: Variants = {
  initial: { opacity: 0 },
  animate: { opacity: 1, transition: { duration: 0.8, ease: easeOutSoft } },
};

export const fadeUp: Variants = {
  initial: { opacity: 0, y: 16 },
  animate: { opacity: 1, y: 0, transition: { duration: 0.6, ease: easeOutSoft } },
};

export const fadeIn: Variants = {
  initial: { opacity: 0 },
  animate: { opacity: 1, transition: { duration: 0.5, ease: easeInOutSoft } },
};

export const modalIn: Variants = {
  initial: { opacity: 0, y: 8 },
  animate: { opacity: 1, y: 0, transition: { duration: 0.5, ease: easeOutSoft } },
  exit:    { opacity: 0, y: 8, transition: { duration: 0.3, ease: easeOutLinear } },
};

export const scaleSettle: Variants = {
  initial: { opacity: 0, scale: 0.98 },
  animate: { opacity: 1, scale: 1, transition: { duration: 0.5, ease: easeOutSoft } },
};

export const sceneExit: Variants = {
  animate: { opacity: 0, transition: { duration: 0.45, ease: easeOutLinear } },
};

export const staggerContainer: Variants = {
  animate: { transition: { staggerChildren: 0.08 } },
};

export const staggerBlock: Variants = {
  animate: { transition: { staggerChildren: 0.12 } },
};
```

### Usage

```tsx
<motion.h1 variants={fadeUp} initial="initial" animate="animate">
  Premium keynote title
</motion.h1>
```

For lists, wrap in a `staggerContainer` and give each child `fadeUp`:

```tsx
<motion.ul variants={staggerContainer} initial="initial" animate="animate">
  {items.map((x) => (
    <motion.li key={x.id} variants={fadeUp}>{x.label}</motion.li>
  ))}
</motion.ul>
```

## CSS-only fallback

For projects without Framer Motion. Drop into global CSS.

```css
:root {
  --sc-ease-out-soft: cubic-bezier(0.22, 1, 0.36, 1);
  --sc-ease-in-out-soft: cubic-bezier(0.4, 0, 0.2, 1);
  --sc-ease-out-linear: cubic-bezier(0.4, 0, 1, 1);
}

@keyframes sc-scene-enter {
  from { opacity: 0; }
  to   { opacity: 1; }
}

@keyframes sc-fade-up {
  from { opacity: 0; transform: translateY(16px); }
  to   { opacity: 1; transform: translateY(0); }
}

@keyframes sc-fade-in {
  from { opacity: 0; }
  to   { opacity: 1; }
}

@keyframes sc-modal-in {
  from { opacity: 0; transform: translateY(8px); }
  to   { opacity: 1; transform: translateY(0); }
}

@keyframes sc-scale-settle {
  from { opacity: 0; transform: scale(0.98); }
  to   { opacity: 1; transform: scale(1); }
}

.sc-scene-enter   { animation: sc-scene-enter 0.8s var(--sc-ease-out-soft) both; }
.sc-fade-up       { animation: sc-fade-up 0.6s var(--sc-ease-out-soft) both; }
.sc-fade-in       { animation: sc-fade-in 0.5s var(--sc-ease-in-out-soft) both; }
.sc-modal-in      { animation: sc-modal-in 0.5s var(--sc-ease-out-soft) both; }
.sc-scale-settle  { animation: sc-scale-settle 0.5s var(--sc-ease-out-soft) both; }

/* Stagger: parent sets --sc-stagger (default 0.08s), each child gets --sc-i. */
.sc-stagger > * {
  animation-delay: calc(var(--sc-i, 0) * var(--sc-stagger, 0.08s));
}

@media (prefers-reduced-motion: reduce) {
  .sc-scene-enter,
  .sc-fade-up,
  .sc-fade-in,
  .sc-modal-in,
  .sc-scale-settle {
    animation-duration: 0.01s;
  }
}
```

## Tailwind config fragment

Extend `tailwind.config.js`:

```js
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      transitionTimingFunction: {
        "sc-out-soft": "cubic-bezier(0.22, 1, 0.36, 1)",
        "sc-in-out-soft": "cubic-bezier(0.4, 0, 0.2, 1)",
        "sc-out-linear": "cubic-bezier(0.4, 0, 1, 1)",
      },
      transitionDuration: {
        "sc-fast": "450ms",
        "sc-base": "600ms",
        "sc-slow": "800ms",
      },
    },
  },
};
```

## Spring guidance

Spring is opt-in, not default. Use it only when a subtle settle is genuinely better than an eased curve — typically on a single focal element, never on staggered children.

```tsx
<motion.div
  variants={{
    initial: { opacity: 0, y: 8 },
    animate: {
      opacity: 1,
      y: 0,
      transition: { type: "spring", stiffness: 140, damping: 20, mass: 1 },
    },
  }}
  initial="initial"
  animate="animate"
/>
```

Do not raise stiffness above 160 or lower damping below 18; anything further starts to feel bouncy, which Stagecraft rejects.

## Anti-patterns

- Do not stack multiple spring animations simultaneously.
- Do not animate `scale` on many elements at once — reserve `scaleSettle` for a single focal moment.
- Do not apply `sceneEnter` to child elements; it is a root-only token.
- Do not change any duration or easing on a per-component basis; if a component needs a new motion feel, it is almost certainly a reveal-pattern problem, not a token problem.
