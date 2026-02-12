# SuperDesign Skill

> **Author:** Marcus (AI Agent)  
> **Created:** 2026-02-12  
> **Location:** ~/clawd/skills/superdesign

Generate UI mockups and design variations as standalone HTML files. Based on the open-source SuperDesign methodology.

## Source
- Open-source repo: https://github.com/superdesigndev/superdesign
- Methodology: https://github.com/superdesigndev/superdesign-skill

## When to Use
- Generating UI mockups before coding
- Exploring design variations for a feature
- Creating wireframes for new pages
- Prototyping landing pages or app screens
- Iterating on existing UI designs

---

## Core Workflow

### For Existing UI (Redesign/Iteration)

**Step 1: Gather Context**
1. Check if `.superdesign/init/` exists with analysis files
2. If missing, run init analysis (see INIT section below)
3. Read the design system: `.superdesign/design-system.md`

**Step 2: Collect UI Source Files**
Trace imports from target page to find ALL UI-touching files:
- Target page component + all sub-components
- Layout components (nav, sidebar, header, footer)
- Base UI components (Button, Card, Input, etc.)
- Styling files (globals.css, component CSS)
- Config (tailwind.config)

**Context Collection Principle:**
- Keep: ALL JSX, styles, className, props, CSS, config
- Strip: data fetching, event handlers, API calls, auth checks

**Step 3a: Create Pixel-Perfect Reproduction**
FIRST create an HTML that exactly matches the current UI before any changes.

**Step 3b: Create Design Variations**
Generate 2-3 variations exploring different directions. Each variation = separate HTML file.

### For Brand New Projects

**Step 1:** Gather requirements
**Step 2:** Create design system document
**Step 3:** Generate initial design + variations

---

## Output Format

All designs output to: `.superdesign/design_iterations/`

### HTML Template
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{Design Name}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    // Import design system tokens here
                }
            }
        }
    </script>
</head>
<body class="bg-white text-black">
    <!-- Design content here -->
</body>
</html>
```

### Naming Convention
- New designs: `{design_name}_{n}.html` (e.g., `dashboard_1.html`, `dashboard_2.html`)
- Iterations: `{current_file}_{n}.html` (e.g., `dashboard_1_1.html`, `dashboard_1_2.html`)

---

## Technical Specifications

1. **Images**: NEVER include external images. Use CSS placeholders only (colored divs, SVG patterns)
2. **Styles**: Use Tailwind CSS via CDN
3. **Colors**: Text should primarily be black or white for readability
4. **Spacing**: Use 4pt or 8pt spacing system — all margins, padding must be exact multiples
5. **Responsive**: Must look good on mobile, tablet, and desktop
6. **Brand Assets**: Include actual logo SVGs; use placeholders for photos/illustrations

## Design Style Principles

- Perfect balance between elegant minimalism and functional design
- Well-proportioned white space for clean layout
- Clear information hierarchy using subtle shadows and modular card layouts
- Refined rounded corners
- Responsive design that adapts gracefully

---

## INIT: Project Analysis

If `.superdesign/init/` doesn't exist, create these 5 files:

### 1. components.md
Inventory of shared UI primitives:
```markdown
# UI Components

## Button
- Location: src/components/ui/Button.tsx
- Variants: primary, secondary, ghost, destructive
- Sizes: sm, md, lg

## Card
- Location: src/components/ui/Card.tsx
...
```

### 2. layouts.md
Full source code of layout components (Nav, Sidebar, Header, Footer, Layout wrappers).

### 3. routes.md
Route/page mapping:
```markdown
# Routes
- / → src/pages/Home.tsx
- /dashboard → src/pages/Dashboard.tsx
...
```

### 4. theme.md
Design tokens extracted from:
- CSS variables from globals.css
- Tailwind config (colors, spacing, fonts)
- Any theme provider values

### 5. pages.md
Page component dependency trees:
```markdown
# Dashboard Page
- src/pages/Dashboard.tsx
  - src/components/DashboardHeader.tsx
  - src/components/StatsCard.tsx
  - src/components/ui/Card.tsx
  - src/components/ui/Button.tsx
```

---

## Design System Document

Create `.superdesign/design-system.md` with:

```markdown
# Design System

## Product Context
- What the product does
- Key pages and features
- Target users

## Colors
- Primary: #000000
- Secondary: #666666
- Accent: #F59E0B
- Background: #FFFFFF
- Surface: #F9FAFB

## Typography
- Font Family: Inter, system-ui, sans-serif
- Headings: 600-700 weight
- Body: 400 weight
- Sizes: 12/14/16/18/24/32/48px

## Spacing
- Base unit: 4px
- Common values: 4, 8, 12, 16, 24, 32, 48, 64px

## Components
- Border radius: 4px (sm), 8px (md), 12px (lg)
- Shadows: sm (subtle), md (card), lg (modal)
- Button styles: solid, outline, ghost

## Layout
- Max width: 1280px
- Sidebar width: 256px
- Header height: 64px
```

---

## Variation Guidelines

When generating variations:

1. **Default to 2 variations** unless user specifies otherwise
2. Each variation explores ONE distinct direction:
   - "Conversion-focused with prominent CTAs"
   - "Content-first editorial layout"
   - "Dense power-user interface"
3. **Design system = hard constraint**: Never invent new colors, fonts, or styles outside the design system
4. End each variation prompt with: "Use ONLY the fonts, colors, spacing defined in the design system."

---

## Common Mistakes to Avoid

❌ Skipping pixel-perfect reproduction and jumping to redesign
❌ Inventing colors/fonts not in the design system
❌ Missing layout files (broken reproduction)
❌ Trimming JSX/CSS (loses visual details)
❌ Generating too many variations (stick to 2 unless asked)
❌ Using external images (won't render)

---

## Viewing Designs

```bash
# Quick preview
open .superdesign/design_iterations/dashboard_1.html

# Serve locally with live reload
npx serve .superdesign/design_iterations -p 3333

# Or use Python
cd .superdesign/design_iterations && python -m http.server 3333
```
