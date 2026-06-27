#!/bin/bash

# claude-code-starter-kit installer
# Usage: bash install.sh [target-project-path]
# Default target: current directory

set -e

TOOLKIT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${1:-$(pwd)}"
CLAUDE_DIR="$TARGET/.claude"

echo ""
echo "🤖 Claude Code Starter Kit"
echo "=========================="
echo "Installing into: $TARGET"
echo ""

mkdir -p "$CLAUDE_DIR/skills" "$CLAUDE_DIR/agents" "$CLAUDE_DIR/hooks" "$CLAUDE_DIR/logs"

# Skills
echo "📚 Skills..."
for skill in "$TOOLKIT/skills"/*/; do
  name=$(basename "$skill")
  mkdir -p "$CLAUDE_DIR/skills/$name"
  cp "$skill/SKILL.md" "$CLAUDE_DIR/skills/$name/SKILL.md"
  echo "   ✅ $name"
done

# Agents
echo ""
echo "🤖 Agents..."
for agent in "$TOOLKIT/agents"/*.md; do
  name=$(basename "$agent")
  cp "$agent" "$CLAUDE_DIR/agents/$name"
  echo "   ✅ $name"
done

# Hooks
echo ""
echo "🪝 Hooks..."
for hook in "$TOOLKIT/hooks"/*.sh; do
  name=$(basename "$hook")
  cp "$hook" "$CLAUDE_DIR/hooks/$name"
  chmod +x "$CLAUDE_DIR/hooks/$name"
  echo "   ✅ $name"
done

# settings.json
if [ ! -f "$CLAUDE_DIR/settings.json" ]; then
  cp "$TOOLKIT/settings.json" "$CLAUDE_DIR/settings.json"
  echo ""
  echo "⚙️  settings.json installed"
else
  echo ""
  echo "⚙️  settings.json already exists — skipped"
fi

# .mcp.json
if [ ! -f "$TARGET/.mcp.json" ]; then
  cp "$TOOLKIT/mcp/.mcp.json" "$TARGET/.mcp.json"
  echo "🔌 .mcp.json installed (edit with your connection strings)"
else
  echo "🔌 .mcp.json already exists — skipped"
fi

# CLAUDE.md
if [ ! -f "$TARGET/CLAUDE.md" ]; then
  cp "$TOOLKIT/CLAUDE.md" "$TARGET/CLAUDE.md"
  echo "🧠 CLAUDE.md template installed (fill in your project details)"
else
  echo "🧠 CLAUDE.md already exists — skipped"
fi

echo ""
echo "=========================="
echo "✅ Done!"
echo ""
echo "Next steps:"
echo "  1. Edit CLAUDE.md with your project details"
echo "  2. Edit .mcp.json with your connection strings"
echo "  3. Run: claude"
echo "  4. Type: /onboard"
echo ""
