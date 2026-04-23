# Example 3 — Pricing card grid

A busy three-tier pricing section elevated to a calm comparison. Demonstrates border reduction, unified spacing, `block-by-block` stagger on scroll, and emphasis through typography rather than color.

## Before

```tsx
const tiers = [
  { name: "Starter", price: "$0", featured: false, features: ["1 project", "Community support", "1GB storage"] },
  { name: "Pro",     price: "$29", featured: true,  features: ["Unlimited projects", "Priority support", "100GB storage", "Team collaboration", "Advanced analytics"] },
  { name: "Enterprise", price: "Custom", featured: false, features: ["SSO", "Dedicated support", "SLA", "Custom contracts"] },
];

export function Pricing() {
  return (
    <section className="py-20 bg-gradient-to-b from-gray-50 to-white">
      <div className="max-w-6xl mx-auto px-6">
        <h2 className="text-4xl font-black text-center mb-4">Choose your plan</h2>
        <p className="text-center text-gray-600 mb-12 text-lg">Pick what fits today, change it tomorrow.</p>
        <div className="grid md:grid-cols-3 gap-6">
          {tiers.map((tier) => (
            <div
              key={tier.name}
              className={`rounded-2xl p-8 border-2 shadow-xl ${
                tier.featured
                  ? "border-purple-500 bg-gradient-to-br from-purple-50 to-pink-50 scale-105 shadow-2xl shadow-purple-500/40"
                  : "border-gray-200 bg-white"
              }`}
            >
              {tier.featured && (
                <div className="inline-block bg-purple-500 text-white text-xs font-black uppercase px-3 py-1 rounded-full mb-4">
                  Most Popular
                </div>
              )}
              <h3 className="text-2xl font-black mb-2">{tier.name}</h3>
              <div className="text-5xl font-black mb-6">{tier.price}</div>
              <ul className="space-y-3 mb-8">
                {tier.features.map((f) => (
                  <li key={f} className="flex gap-2 text-gray-700">✅ {f}</li>
                ))}
              </ul>
              <button className={`w-full py-3 rounded-xl font-black ${
                tier.featured ? "bg-purple-500 text-white shadow-lg" : "bg-gray-900 text-white"
              }`}>
                Get started
              </button>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}
```

## Audit findings

1. **Background and tone.** `from-gray-50 to-white` gradient + per-card gradient on featured tier. `current → target`: `sc-bg` section, `sc-surface-2` cards, no gradients.
2. **Type discipline.** `font-black` on headings, prices, CTAs, and even the "Most Popular" badge. `current → target`: 500 for heading, 500 for price, 400 for features; no 900-weight anywhere.
3. **Emphasis restraint.** Featured tier stacks: border-2 purple, gradient, `scale-105`, glow shadow, color CTA. Five emphasis methods on one element. `current → target`: one emphasis — a soft surface step up and a subtle top border stripe.
4. **Motion coherence.** None. `current → target`: `block-by-block` on scroll.
5. **Alignment.** Three cards at different visual weights; featured card physically larger. `current → target`: uniform size, emphasis through surface tone only.

**Red flags:** scale pop on child, glow spam, stacked gradients, competing focal regions (purple gradient card vs. dark CTAs).

## Ranked changes

1. Palette + surfaces unified — removes four emphasis methods in one diff.
2. Type rework across the section.
3. Add `block-by-block` scroll-triggered stagger.
4. Featured tier emphasis → subtle surface elevation + caption label.

## After

```tsx
import { motion } from "framer-motion";
import { staggerBlock, fadeUp } from "@/lib/stagecraft-motion";

const tiers = [
  { name: "Starter", price: "$0", featured: false, features: ["1 project", "Community support", "1GB storage"] },
  { name: "Pro",     price: "$29", featured: true,  features: ["Unlimited projects", "Priority support", "100GB storage", "Team collaboration", "Advanced analytics"] },
  { name: "Enterprise", price: "Custom", featured: false, features: ["SSO", "Dedicated support", "SLA", "Custom contracts"] },
];

export function Pricing() {
  return (
    <section className="bg-sc-bg text-sc-text py-sc-24 font-sc-sans">
      <div className="max-w-6xl mx-auto px-sc-6">
        <motion.h2
          variants={fadeUp}
          initial="initial"
          whileInView="animate"
          viewport={{ once: true, amount: 0.5 }}
          className="text-sc-title font-medium text-center mb-sc-3"
        >
          Choose your plan
        </motion.h2>
        <motion.p
          variants={fadeUp}
          initial="initial"
          whileInView="animate"
          viewport={{ once: true, amount: 0.5 }}
          className="text-sc-body text-sc-text-secondary text-center mb-sc-12"
        >
          Pick what fits today, change it tomorrow.
        </motion.p>

        <motion.div
          variants={staggerBlock}
          initial="initial"
          whileInView="animate"
          viewport={{ once: true, amount: 0.3 }}
          className="grid md:grid-cols-3 gap-sc-6"
        >
          {tiers.map((tier) => (
            <motion.div
              key={tier.name}
              variants={fadeUp}
              className={`rounded-sc-lg p-sc-8 border border-sc-border ${
                tier.featured ? "bg-sc-surface-2" : "bg-sc-surface-1"
              }`}
            >
              {tier.featured && (
                <div className="text-sc-caption text-sc-text-secondary tracking-wide mb-sc-4 uppercase">
                  Most popular
                </div>
              )}
              <h3 className="text-sc-heading font-medium mb-sc-2">{tier.name}</h3>
              <div className="text-sc-display font-medium mb-sc-8 tracking-tight">
                {tier.price}
              </div>
              <ul className="space-y-sc-3 mb-sc-8">
                {tier.features.map((f) => (
                  <li key={f} className="text-sc-body text-sc-text-secondary">
                    {f}
                  </li>
                ))}
              </ul>
              <button className={`w-full py-sc-3 rounded-sc-md text-sc-body font-medium transition-colors ${
                tier.featured
                  ? "bg-sc-text text-sc-bg hover:bg-sc-accent-neutral"
                  : "border border-sc-border text-sc-text hover:bg-sc-surface-2"
              }`}>
                Get started
              </button>
            </motion.div>
          ))}
        </motion.div>
      </div>
    </section>
  );
}
```

## What we deliberately did not change

- Tier count stays at three. We did not consolidate; pricing structure is product data, not style.
- Feature lists stay verbatim — Stagecraft does not rewrite copy.
- The "Most popular" label stays, just dimmer. Removing it would lose information.
- We did not replace checkmarks with a custom icon set. Plain text is calm; icons would re-introduce noise.

## Re-score

All dimensions at target. Motion uses `block-by-block` with `whileInView` so the stagger fires when the section enters the viewport instead of on load. Featured tier emphasis is carried by surface-tone step (`sc-surface-2` vs. `sc-surface-1`) and a single caption — no border color, no scale, no glow. Accessibility retained (`button` elements keep default focus rings; contrast on `sc-surface-2` passes WCAG AA).
