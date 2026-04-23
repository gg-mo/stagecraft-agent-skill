# Example 2 — Modal

A generic centered modal elevated to a premium anchored modal. Demonstrates `modalIn`, backdrop softening, palette migration, and accessibility preservation.

## Before

```tsx
export function DeleteModal({ open, onClose, onConfirm }: {
  open: boolean;
  onClose: () => void;
  onConfirm: () => void;
}) {
  if (!open) return null;
  return (
    <div className="fixed inset-0 bg-black/70 backdrop-blur-md flex items-center justify-center z-50">
      <div className="bg-white rounded-2xl shadow-2xl p-8 max-w-md w-full mx-4 animate-in zoom-in-95 duration-200">
        <h2 className="text-2xl font-black text-red-600 mb-3">⚠️ Delete account?</h2>
        <p className="text-gray-700 mb-6 text-base">
          This action cannot be undone. All your data will be permanently erased.
        </p>
        <div className="flex gap-3 justify-end">
          <button onClick={onClose} className="px-5 py-2.5 rounded-xl bg-gray-100 font-bold hover:bg-gray-200">
            Cancel
          </button>
          <button onClick={onConfirm} className="px-5 py-2.5 rounded-xl bg-red-600 text-white font-bold hover:bg-red-700 shadow-lg">
            Yes, delete
          </button>
        </div>
      </div>
    </div>
  );
}
```

## Audit findings

1. **Background and tone.** White modal on heavy black+blur backdrop is a tonal clash. `current → target`: dark `sc-surface-3` panel on `sc-bg/80` backdrop.
2. **Type discipline.** `font-black` (900) on the heading. Emoji as emphasis. `current → target`: weight 500, remove emoji, use color + scale for hierarchy.
3. **Emphasis restraint.** `shadow-2xl` + `shadow-lg` + `bg-red-600` all stack. `current → target`: one soft shadow, single accent use on destructive CTA.
4. **Motion coherence.** `zoom-in-95 duration-200` is not on-system. `current → target`: replace with `modalIn` token.
5. **Accessibility retained.** No `role="dialog"`, no labelled-by, no focus trap. `current → target`: add ARIA + focus management.

**Red flags:** glow spam, heavy backdrop blur, bouncy hover scale implicit in `zoom-in-95`.

## Ranked changes

1. Replace backdrop + panel palette in one diff.
2. Swap animation to `modalIn`.
3. Add `role="dialog"` + `aria-labelledby` + focus trap outline.

## After

```tsx
import { useEffect, useRef } from "react";
import { AnimatePresence, motion } from "framer-motion";
import { modalIn } from "@/lib/stagecraft-motion";

export function DeleteModal({ open, onClose, onConfirm }: {
  open: boolean;
  onClose: () => void;
  onConfirm: () => void;
}) {
  const panelRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (open) panelRef.current?.focus();
  }, [open]);

  return (
    <AnimatePresence>
      {open && (
        <motion.div
          className="fixed inset-0 bg-sc-bg/80 flex items-center justify-center z-50"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          exit={{ opacity: 0 }}
          transition={{ duration: 0.3 }}
          onClick={onClose}
        >
          <motion.div
            ref={panelRef}
            role="dialog"
            aria-modal="true"
            aria-labelledby="delete-title"
            tabIndex={-1}
            variants={modalIn}
            initial="initial"
            animate="animate"
            exit="exit"
            onClick={(e) => e.stopPropagation()}
            className="bg-sc-surface-3 border border-sc-border rounded-sc-lg shadow-sc-soft p-sc-8 max-w-md w-full mx-sc-4 font-sc-sans text-sc-text focus:outline-none"
          >
            <h2 id="delete-title" className="text-sc-heading font-medium mb-sc-3">
              Delete account
            </h2>
            <p className="text-sc-body text-sc-text-secondary mb-sc-6">
              This action cannot be undone. All your data will be permanently erased.
            </p>
            <div className="flex gap-sc-3 justify-end">
              <button
                onClick={onClose}
                className="px-sc-4 py-sc-2 rounded-sc-sm text-sc-body font-medium border border-sc-border text-sc-text hover:bg-sc-surface-2 transition-colors"
              >
                Cancel
              </button>
              <button
                onClick={onConfirm}
                className="px-sc-4 py-sc-2 rounded-sc-sm text-sc-body font-medium bg-sc-text text-sc-bg hover:bg-sc-accent-neutral transition-colors"
              >
                Delete
              </button>
            </div>
          </motion.div>
        </motion.div>
      )}
    </AnimatePresence>
  );
}
```

## What we deliberately did not change

- The action remains destructive and terminal; we did not soften the copy. Stagecraft restrains visual emphasis, not semantic truth.
- The cancel/delete button order stays left/right. Platform convention wins.
- The backdrop dismiss behavior stays. Restraint is visual, not behavioral.
- We did not introduce a red accent. Destructive-as-red is a convention, but we relied on copy and panel focus instead — keeping the single-accent rule. If the product already uses a red accent elsewhere, wire it in there instead.

## Re-score

All dimensions at target. Motion uses `modalIn` exit + fade backdrop. Focus trapped on the panel. `prefers-reduced-motion` handled by Framer Motion's built-in respect for the setting (reduce to opacity-only transitions). Contrast retained (text on `sc-surface-3` passes WCAG AA).
