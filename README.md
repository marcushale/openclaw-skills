# OpenClaw Skills

Custom skills for [OpenClaw](https://github.com/openclaw/openclaw) agents.

## Installation

Copy any skill folder to your OpenClaw skills directory:

```bash
# Clone this repo
git clone https://github.com/marcushale/openclaw-skills.git

# Copy a skill to your workspace
cp -r openclaw-skills/skills/superdesign ~/clawd/skills/

# Or symlink for auto-updates
ln -s $(pwd)/openclaw-skills/skills/superdesign ~/clawd/skills/superdesign
```

Then restart your OpenClaw gateway or reload skills.

## Skills

| Skill | Description |
|-------|-------------|
| [superdesign](skills/superdesign/) | Generate UI mockups as standalone HTML with Tailwind CSS |
| [interface-design](skills/interface-design/) | Systematic UI design principles for dashboards and apps |
| [website-extract](skills/website-extract/) | Extract design systems (colors, fonts, spacing) from any URL |

## Skill Format

Each skill follows the OpenClaw skill format:

```
skills/
  skill-name/
    SKILL.md          # Required: Instructions and usage
    scripts/          # Optional: Supporting scripts
    templates/        # Optional: Template files
```

The `SKILL.md` frontmatter can include metadata:

```yaml
---
name: skill-name
description: One-line description for skill discovery
metadata:
  openclaw:
    requires:
      bins: [curl, jq]     # Required CLI tools
      env: [API_KEY]       # Required environment variables
---
```

## Contributing

PRs welcome. Each skill should:
1. Have a clear, focused purpose
2. Include complete usage instructions in `SKILL.md`
3. List any dependencies (CLI tools, env vars, APIs)

## License

MIT
