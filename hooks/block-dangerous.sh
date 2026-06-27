#!/bin/bash
# PreToolUse hook — blocks dangerous bash commands before execution
# Wired in settings.json under hooks.PreToolUse

COMMAND="$1"

BLOCKED_PATTERNS=(
  "rm -rf /"
  "rm -rf ~"
  "DROP TABLE"
  "DROP DATABASE"
  "TRUNCATE"
  "git push --force"
  "git reset --hard"
  "> /dev/sda"
  "chmod -R 777"
  "curl.*| bash"
  "wget.*| bash"
)

for pattern in "${BLOCKED_PATTERNS[@]}"; do
  if echo "$COMMAND" | grep -qi "$pattern"; then
    echo "🚫 BLOCKED by hook: command matches dangerous pattern '$pattern'"
    echo "   Run this manually if you're sure: $COMMAND"
    exit 1
  fi
done

exit 0
