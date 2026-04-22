# Visual System

The single palette, type scale, spacing grid, radius set, and shadow token Stagecraft uses. Pick from this menu. Do not invent values.

## Palette

Dark base with subtle surface steps. High contrast retained for text.

| Token | Value | Use |
|---|---|---|
| `sc-bg` | `#0a0a0b` | page background |
| `sc-surface-1` | `#121214` | low-elevation surface |
| `sc-surface-2` | `#1a1a1d` | mid-elevation surface (cards, panels) |
| `sc-surface-3` | `#232327` | high-elevation surface (modals, popovers) |
| `sc-text` | `#f0f0f2` | primary text (α = 1.0) |
| `sc-text-secondary` | `rgba(240, 240, 242, 0.6)` | secondary text |
| `sc-text-tertiary` | `rgba(240, 240, 242, 0.35)` | tertiary text, metadata |
| `sc-border` | `rgba(255, 255, 255, 0.06)` | subtle separators |

### Accent color

Default is no accent color — monochrome dark plus whites is the correct starting point. If one is needed, pick exactly one of these two, never both in the same view:

- `#7aa2f7` — muted cool blue (for action highlights)
- `#eef0f5` — cool near-white (for highlight surfaces and focal backgrounds)

More than one accent hue in a view is an anti-pattern.

## Typography

### Stack

```css
font-family: -apple-system, "SF Pro Text", Inter, ui-sans-serif, system-ui, sans-serif;
```

### Scale

Five steps. Use no more than three in a single view.

| Token | Size | Line-height | Letter-spacing | Weight |
|---|---|---|---|---|
| `sc-display` | 56px | 1.05 | -0.02em | 500 |
| `sc-title` | 32px | 1.15 | -0.015em | 500 |
| `sc-heading` | 20px | 1.3 | -0.01em | 500 |
| `sc-body` | 15px | 1.5 | 0 | 400 |
| `sc-caption` | 13px | 1.4 | 0 | 400 |

### Weight discipline

Use 400, 500, 600 only. Never 700+. Bold-heavy typography reads loud; Stagecraft prefers weight differences expressed through scale and color, not extra thickness.

## Spacing

4px grid. Use only these values:

`4, 8, 12, 16, 24, 32, 48, 64, 96, 128`

Scale 24+ is preferred for separating major regions; 4–12 for intra-component padding; 16–24 for intra-group gaps.

## Radius

Three values: `8, 12, 16`. Default is `12`. Use `16` for full-bleed cards or modal panels; `8` for dense interactive elements like pills or inputs.

## Shadow

One soft ambient shadow. Stagecraft does not stack dramatic shadows.

```
0 1px 2px rgba(0, 0, 0, 0.4), 0 8px 32px rgba(0, 0, 0, 0.3)
```

Use sparingly, and only for surfaces that float above the base background (modals, popovers, high-elevation cards).

## Tailwind config fragment

```js
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      colors: {
        "sc-bg": "#0a0a0b",
        "sc-surface-1": "#121214",
        "sc-surface-2": "#1a1a1d",
        "sc-surface-3": "#232327",
        "sc-text": "#f0f0f2",
        "sc-text-secondary": "rgba(240, 240, 242, 0.6)",
        "sc-text-tertiary": "rgba(240, 240, 242, 0.35)",
        "sc-border": "rgba(255, 255, 255, 0.06)",
        "sc-accent-blue": "#7aa2f7",
        "sc-accent-neutral": "#eef0f5",
      },
      fontFamily: {
        "sc-sans": [
          "-apple-system",
          "SF Pro Text",
          "Inter",
          "ui-sans-serif",
          "system-ui",
          "sans-serif",
        ],
      },
      fontSize: {
        "sc-display": ["56px", { lineHeight: "1.05", letterSpacing: "-0.02em" }],
        "sc-title":   ["32px", { lineHeight: "1.15", letterSpacing: "-0.015em" }],
        "sc-heading": ["20px", { lineHeight: "1.3",  letterSpacing: "-0.01em" }],
        "sc-body":    ["15px", { lineHeight: "1.5" }],
        "sc-caption": ["13px", { lineHeight: "1.4" }],
      },
      spacing: {
        "sc-1":  "4px",
        "sc-2":  "8px",
        "sc-3":  "12px",
        "sc-4":  "16px",
        "sc-6":  "24px",
        "sc-8":  "32px",
        "sc-12": "48px",
        "sc-16": "64px",
        "sc-24": "96px",
        "sc-32": "128px",
      },
      borderRadius: {
        "sc-sm": "8px",
        "sc-md": "12px",
        "sc-lg": "16px",
      },
      boxShadow: {
        "sc-soft":
          "0 1px 2px rgba(0, 0, 0, 0.4), 0 8px 32px rgba(0, 0, 0, 0.3)",
      },
    },
  },
};
```

## CSS custom properties (non-Tailwind)

```css
:root {
  /* palette */
  --sc-bg: #0a0a0b;
  --sc-surface-1: #121214;
  --sc-surface-2: #1a1a1d;
  --sc-surface-3: #232327;
  --sc-text: #f0f0f2;
  --sc-text-secondary: rgba(240, 240, 242, 0.6);
  --sc-text-tertiary: rgba(240, 240, 242, 0.35);
  --sc-border: rgba(255, 255, 255, 0.06);
  --sc-accent-blue: #7aa2f7;
  --sc-accent-neutral: #eef0f5;

  /* type */
  --sc-sans: -apple-system, "SF Pro Text", Inter, ui-sans-serif, system-ui, sans-serif;

  /* spacing (4px grid) */
  --sc-space-1: 4px;
  --sc-space-2: 8px;
  --sc-space-3: 12px;
  --sc-space-4: 16px;
  --sc-space-6: 24px;
  --sc-space-8: 32px;
  --sc-space-12: 48px;
  --sc-space-16: 64px;
  --sc-space-24: 96px;
  --sc-space-32: 128px;

  /* radius */
  --sc-radius-sm: 8px;
  --sc-radius-md: 12px;
  --sc-radius-lg: 16px;

  /* shadow */
  --sc-shadow-soft: 0 1px 2px rgba(0, 0, 0, 0.4), 0 8px 32px rgba(0, 0, 0, 0.3);
}
```

## Anti-patterns

- Mixing two accent hues in one view.
- Using font weights 700+ to create hierarchy.
- Using spacing values not on the 4px grid.
- Stacking multiple shadows for "depth."
- Using pure `#000` or pure `#fff` instead of the palette tokens.
- Using more than three type-scale steps in a single view.
