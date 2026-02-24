# RTK Exec Wrapper Skill

**Purpose:** Automatically route shell commands through RTK (Rust Token Killer) for 60-95% token savings on common dev operations.

## Prerequisites

Install RTK:
```bash
brew install rtk
```

Verify installation:
```bash
rtk --version
rtk gain  # Should work (not "command not found")
```

## Installation

Copy `scripts/rtk-exec.sh` to your workspace (e.g., `~/clawd/scripts/`):
```bash
cp scripts/rtk-exec.sh ~/clawd/scripts/
chmod +x ~/clawd/scripts/rtk-exec.sh
```

## Usage

Instead of running commands directly:
```bash
exec command:"git status"
```

Route through the wrapper:
```bash
exec command:"./scripts/rtk-exec.sh git status"
```

## What It Does

1. Checks if the command benefits from RTK compression
2. If yes: rewrites command to use RTK (e.g., `git status` → `rtk git status`)
3. If no: passes through unchanged
4. Preserves exit codes for CI/script compatibility

## Commands Automatically Wrapped

| Category | Commands | Typical Savings |
|----------|----------|-----------------|
| **Git** | status, diff, log, show, add, commit, push, pull | 59-95% |
| **GitHub** | gh pr, gh issue, gh run, gh api | 26-87% |
| **Files** | cat→read, grep, rg, ls, find, tree | 50-95% |
| **Tests** | cargo test, npm test, pytest, vitest | 90-99% |
| **Build** | cargo build/clippy/check, tsc, eslint | 80-90% |
| **Containers** | docker ps/images/logs, kubectl get/logs | 60-80% |
| **Python** | ruff, pip | 70-85% |
| **Go** | go test/build/vet | 75-90% |

## Commands NOT Wrapped (Passthrough)

- Already using `rtk` prefix
- Heredocs (`<<`)
- Command substitution (`$(...)`)
- Pipes and chains (`|`, `&&`, `||`)
- Complex grep flags (`-A`, `-B`, `-C`, `-l`, `-c`, `-o`)
- Any command not in the supported list

## Limitations & Workarounds

| Situation | Limitation | Workaround |
|-----------|------------|------------|
| `git status` with many files | Shows ~5 files, truncates rest | Use `git status --porcelain` for full list |
| `grep` with `-A/-B/-C` flags | N/A - auto passthrough | Works automatically |
| Very large diffs | May truncate | Use raw `git diff` for full output |
| `cat` large files | May apply code filtering | Use raw `cat` for exact content |

## Verifying Savings

After using the wrapper, check cumulative savings:
```bash
rtk gain
rtk gain --history
```

## Data Integrity

RTK compresses output but preserves essential information:
- **git status:** Shows modified/untracked file names
- **git diff:** Shows file names, line counts, diff content
- **grep:** Groups by file, shows match counts and line numbers
- **ls:** Tree format with file counts per directory

For full raw output when needed, bypass the wrapper by running commands directly.

## License

MIT - Based on [rtk-ai/rtk](https://github.com/rtk-ai/rtk)

## Credits

- RTK by [rtk-ai](https://github.com/rtk-ai/rtk)
- Wrapper by Marcus Hale / Auderon
