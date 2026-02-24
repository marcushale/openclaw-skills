#!/bin/bash
# rtk-exec.sh — Intelligent RTK wrapper for OpenClaw exec calls
# Routes commands through RTK when beneficial, passes through otherwise
#
# Usage: ./rtk-exec.sh "git status"
# Returns: Compressed output (if RTK handles it) or raw output

set -euo pipefail

# Check if RTK is available
if ! command -v rtk &>/dev/null; then
    echo "[rtk-exec] RTK not installed, running raw command" >&2
    eval "$@"
    exit $?
fi

CMD="$*"

# Skip if already using rtk
if [[ "$CMD" == rtk\ * ]]; then
    eval "$CMD"
    exit $?
fi

# Skip heredocs and complex shell constructs
if [[ "$CMD" == *'<<'* ]] || [[ "$CMD" == *'$('* ]]; then
    eval "$CMD"
    exit $?
fi

# Determine if this command benefits from RTK
REWRITTEN=""

# --- Git commands ---
if [[ "$CMD" =~ ^git[[:space:]]+(status|diff|log|show|add|commit|push|pull|branch|fetch|stash) ]]; then
    REWRITTEN="rtk $CMD"

# --- GitHub CLI ---
elif [[ "$CMD" =~ ^gh[[:space:]]+(pr|issue|run|api) ]]; then
    REWRITTEN="rtk $CMD"

# --- File operations ---
elif [[ "$CMD" =~ ^cat[[:space:]]+ ]]; then
    # cat file → rtk read file
    REWRITTEN="${CMD/cat /rtk read }"

elif [[ "$CMD" =~ ^(grep|rg)[[:space:]]+ ]]; then
    # grep/rg → rtk grep (different arg format)
    # RTK grep: rtk grep <PATTERN> [PATH] [EXTRA_ARGS]
    # 
    # Only handle simple cases. Pass through if:
    # - Context flags (-A, -B, -C) - RTK handles differently
    # - Output modification flags (-l, -c, -o)
    # - Complex patterns with spaces
    
    # Passthrough complex cases
    if [[ "$CMD" =~ -[ABCclo] ]]; then
        REWRITTEN=""
    # Simple case: grep [-r] PATTERN PATH
    elif [[ "$CMD" =~ ^(grep|rg)[[:space:]]+(-r[[:space:]]+)?[\"\']?([^\"\'[:space:]-]+)[\"\']?[[:space:]]+([^[:space:]]+)$ ]]; then
        PATTERN="${BASH_REMATCH[3]}"
        SEARCH_PATH="${BASH_REMATCH[4]}"
        REWRITTEN="rtk grep \"$PATTERN\" $SEARCH_PATH"
    # Simple case: grep [-r] PATTERN (no path)
    elif [[ "$CMD" =~ ^(grep|rg)[[:space:]]+(-r[[:space:]]+)?[\"\']?([^\"\'[:space:]-]+)[\"\']?$ ]]; then
        PATTERN="${BASH_REMATCH[3]}"
        REWRITTEN="rtk grep \"$PATTERN\" ."
    else
        # Can't parse safely, pass through
        REWRITTEN=""
    fi

elif [[ "$CMD" =~ ^ls[[:space:]]* ]] || [[ "$CMD" == "ls" ]]; then
    REWRITTEN="rtk $CMD"

elif [[ "$CMD" =~ ^find[[:space:]]+ ]]; then
    REWRITTEN="rtk $CMD"

elif [[ "$CMD" =~ ^tree[[:space:]]* ]] || [[ "$CMD" == "tree" ]]; then
    REWRITTEN="rtk $CMD"

# --- Test runners ---
elif [[ "$CMD" =~ ^(cargo[[:space:]]+test|npm[[:space:]]+test|pnpm[[:space:]]+test|pytest|vitest) ]]; then
    REWRITTEN="rtk $CMD"

# --- Build/lint ---
elif [[ "$CMD" =~ ^cargo[[:space:]]+(build|clippy|check) ]]; then
    REWRITTEN="rtk $CMD"

elif [[ "$CMD" =~ ^(tsc|eslint|prettier)[[:space:]]* ]]; then
    REWRITTEN="rtk $CMD"

# --- Containers ---
elif [[ "$CMD" =~ ^docker[[:space:]]+(ps|images|logs) ]]; then
    REWRITTEN="rtk $CMD"

elif [[ "$CMD" =~ ^kubectl[[:space:]]+(get|logs|describe) ]]; then
    REWRITTEN="rtk $CMD"

# --- Python ---
elif [[ "$CMD" =~ ^(ruff|pip)[[:space:]]+ ]]; then
    REWRITTEN="rtk $CMD"

# --- Go ---
elif [[ "$CMD" =~ ^go[[:space:]]+(test|build|vet) ]]; then
    REWRITTEN="rtk $CMD"

fi

# Execute the appropriate command
if [[ -n "$REWRITTEN" ]]; then
    # Run through RTK
    eval "$REWRITTEN"
    exit $?
else
    # Pass through unchanged
    eval "$CMD"
    exit $?
fi
