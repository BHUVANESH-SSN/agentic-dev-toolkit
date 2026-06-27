#!/bin/bash
# PostWrite hook — auto-lints after Claude writes a file
# Wired in settings.json under hooks.PostWrite

FILE="$1"

if [[ "$FILE" == *.ts || "$FILE" == *.tsx ]]; then
  echo "🔍 Linting $FILE..."
  npx eslint "$FILE" --fix --quiet 2>/dev/null && echo "✅ Lint passed" || echo "⚠️  Lint warnings (check manually)"

elif [[ "$FILE" == *.py ]]; then
  echo "🔍 Linting $FILE..."
  python -m ruff check "$FILE" --fix 2>/dev/null && echo "✅ Lint passed" || echo "⚠️  Lint warnings (check manually)"

elif [[ "$FILE" == *.js ]]; then
  echo "🔍 Linting $FILE..."
  npx eslint "$FILE" --fix --quiet 2>/dev/null && echo "✅ Lint passed" || echo "⚠️  Lint warnings (check manually)"
fi

exit 0
