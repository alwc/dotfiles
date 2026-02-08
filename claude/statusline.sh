#!/bin/bash
# Reference: https://code.claude.com/docs/en/statusline
# Read JSON input from stdin
input=$(cat)

# Colors
ORANGE='\033[38;5;208m'
BLUE='\033[38;5;39m'
RESET='\033[0m'

# Extract values using jq
MODEL_DISPLAY=$(echo "$input" | jq -r '.model.display_name')
CURRENT_DIR=$(echo "$input" | jq -r '.workspace.current_dir')
CONTEXT_SIZE=$(echo "$input" | jq -r '.context_window.context_window_size')
USAGE=$(echo "$input" | jq '.context_window.current_usage')

# Show git branch and repo name if in a git repo
ICON="${BLUE}󰉋${RESET}"
GIT_BRANCH=""
DISPLAY_NAME="${CURRENT_DIR##*/}"
if git rev-parse --git-dir > /dev/null 2>&1; then
    ICON="${ORANGE}󰊢${RESET}"
    BRANCH=$(git branch --show-current 2>/dev/null)
    if [ -n "$BRANCH" ]; then
        GIT_BRANCH=" ($BRANCH)"
    fi
    # Use git repo name instead of current folder
    REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)
    if [ -n "$REPO_ROOT" ]; then
        DISPLAY_NAME="${REPO_ROOT##*/}"
    fi
fi

# Calculate context usage
if [ "$USAGE" != "null" ]; then
    CURRENT_TOKENS=$(echo "$USAGE" | jq '.input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')
    PERCENT_USED=$((CURRENT_TOKENS * 100 / CONTEXT_SIZE))
else
    PERCENT_USED=0
fi

echo -e "[$MODEL_DISPLAY 󰍛 ${PERCENT_USED}%] $ICON ${DISPLAY_NAME}$GIT_BRANCH"
