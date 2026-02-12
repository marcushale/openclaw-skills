# Website Extract Skill

> **Author:** Marcus (AI Agent)  
> **Created:** 2026-02-12  
> **Location:** ~/clawd/skills/website-extract

Extract design systems from any website: colors, fonts, spacing, and layout patterns.

## Usage

```bash
# Extract design system from a URL
node scripts/website-extract.js https://example.com

# Extract with custom output path
node scripts/website-extract.js https://example.com --output design-system.json

# Extract specific elements only
node scripts/website-extract.js https://example.com --colors --fonts

# Generate Tailwind config
node scripts/website-extract.js https://example.com --tailwind
```

## Output Formats

### Design System JSON (default)
```json
{
  "url": "https://example.com",
  "extractedAt": "2026-02-12T15:42:00Z",
  "colors": {
    "primary": ["#8B5CF6", "#7C3AED"],
    "neutral": ["#0d1117", "#161b22", "#f0f6fc"],
    "accent": ["#10b981"]
  },
  "fonts": {
    "families": ["Inter", "Roboto Mono"],
    "googleFonts": ["https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700"],
    "fontFaceRules": ["@font-face { font-family: 'Custom'; src: url(...) }"]
  },
  "typography": {
    "headings": { "h1": "48px/1.2 Inter", "h2": "36px/1.3 Inter" },
    "body": "16px/1.5 Inter"
  },
  "spacing": ["4px", "8px", "16px", "24px", "32px", "48px", "64px"],
  "borderRadius": ["4px", "8px", "12px", "9999px"],
  "shadows": ["0 1px 3px rgba(0,0,0,0.1)", "0 4px 6px rgba(0,0,0,0.1)"]
}
```

### Tailwind Config (--tailwind)
```js
module.exports = {
  theme: {
    extend: {
      colors: {
        primary: { DEFAULT: '#8B5CF6', dark: '#7C3AED' },
        neutral: { 100: '#f0f6fc', 800: '#161b22', 900: '#0d1117' }
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
        mono: ['Roboto Mono', 'monospace']
      }
    }
  }
}
```

### CSS Variables (--css)
```css
:root {
  --color-primary: #8B5CF6;
  --color-primary-dark: #7C3AED;
  --font-sans: 'Inter', system-ui, sans-serif;
  --spacing-1: 4px;
  --spacing-2: 8px;
  /* ... */
}
```

## What Gets Extracted

| Category | Extraction Method |
|----------|-------------------|
| **Colors** | CSS variables, Tailwind classes, inline styles, computed styles |
| **Fonts** | Google Fonts links, @font-face rules, computed font-family |
| **Typography** | Font sizes, line heights, letter spacing per element type |
| **Spacing** | Margin/padding values, gap values |
| **Border Radius** | All border-radius values found |
| **Shadows** | box-shadow values |
| **Breakpoints** | Media query breakpoints from stylesheets |

## Integration with SuperDesign Skill

Use website-extract to get the design system, then use superdesign to generate new UIs:

```bash
# 1. Extract design system from reference site
node scripts/website-extract.js https://linear.app --output linear-design.json

# 2. Use extracted system in superdesign prompt
# "Create a task management dashboard using the Linear design system"
# Reference: linear-design.json
```

## Requirements

- Node.js 18+
- Puppeteer (auto-installs on first run)

## Limitations

- Cannot extract from sites requiring authentication
- Some fonts may be blocked by CORS
- Dynamic/JS-rendered content captured after 3s wait
