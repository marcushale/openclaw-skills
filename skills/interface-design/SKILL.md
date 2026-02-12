# Interface Design Skill

> Craft · Memory · Consistency

Build interfaces with intention. Maintain systematic consistency across sessions.

**Use for:** Dashboards, admin panels, SaaS apps, tools, data interfaces.
**Not for:** Landing pages, marketing sites (use frontend-design skill).

---

## Core Philosophy

When building UI, design decisions get made: spacing values, colors, depth strategy, surface elevation. Without structure, those decisions drift across sessions.

This skill enforces:
- **Intent-first design** — Every choice must answer "why this?"
- **Systematic consistency** — Tokens, spacing, depth follow a system
- **Memory** — Decisions persist in `.interface-design/system.md`

---

## Before Every UI Component

State these explicitly before writing code:

```
Intent: [who is this human, what must they do, how should it feel]
Palette: [colors — and WHY they fit this product's world]
Depth: [borders / shadows / layered — and WHY]
Surfaces: [elevation scale — and WHY this color temperature]
Typography: [typeface — and WHY it fits the intent]
Spacing: [base unit, e.g., 4px or 8px]
```

If you can't explain WHY for each choice, you're defaulting.

---

## Product Domain Exploration (New Projects)

Before proposing any direction, produce all four:

1. **Domain** — Concepts, metaphors, vocabulary from this product's world (5+ items)
2. **Color World** — What colors exist naturally in this domain? (5+ items)
3. **Signature** — One element that could only exist for THIS product
4. **Defaults to Reject** — 3 obvious patterns to avoid

---

## Craft Foundations

### Surface Elevation
- Surfaces stack: base → cards → dropdowns → modals
- Dark mode: higher elevation = slightly lighter (2-3% per level)
- Changes should be barely perceptible but felt

### Borders
- Use low opacity rgba, not solid colors
- Build a progression: subtle → default → strong → focus
- Squint test: hierarchy visible, nothing harsh

### Spacing
- Pick a base unit (4px or 8px), use multiples only
- Scale: micro (icon gaps) → component → section → major

### Depth (Pick ONE)
- **Borders-only** — Clean, technical, dense
- **Subtle shadows** — Soft lift, approachable
- **Layered shadows** — Premium, dimensional

### Typography
- Four levels: primary → secondary → tertiary → muted
- Headlines: heavier weight, tighter tracking
- Data: monospace with `tabular-nums`

---

## The Mandate

Before showing output, run these checks:

1. **Swap Test** — Would swapping for defaults feel different?
2. **Squint Test** — Hierarchy visible, nothing harsh?
3. **Signature Test** — Can you point to 5 specific elements?
4. **Token Test** — Do CSS variables sound like this product?

If any fails, iterate before presenting.

---

## Memory System

After establishing direction, save to `.interface-design/system.md`:

```markdown
# Design System

## Direction
Personality: [e.g., Precision & Density]
Foundation: [e.g., Cool (slate)]
Depth: [e.g., Borders-only]

## Tokens
### Spacing
Base: 4px
Scale: 4, 8, 12, 16, 24, 32

### Colors
--foreground: slate-900
--secondary: slate-600
--accent: blue-600

## Patterns
### Button Primary
- Height: 36px
- Padding: 12px 16px
- Radius: 6px

### Card Default
- Border: 0.5px solid rgba(...)
- Padding: 16px
- Radius: 8px
```

**Load this file at session start.** Apply established patterns.

---

## Avoid

- Harsh borders (first thing you see = too strong)
- Dramatic surface jumps
- Inconsistent spacing
- Mixed depth strategies
- Missing interaction states
- Native form elements for styled UI (build custom)
- Random hex values (everything maps to tokens)

---

## Reference

Full principles and examples: `references/` directory
- `principles.md` — Detailed craft guidance
- `validation.md` — Memory management rules
- `critique.md` — Post-build critique protocol

---

*Based on [interface-design](https://github.com/Dammyjay93/interface-design) by Dammyjay93*
