#!/usr/bin/env bash
# Installs the 17 agents in your AI tool. Usage: ./install.sh claude|cursor|codex
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
case "${1:-}" in
  claude)
    mkdir -p "$HOME/.claude/agents"
    cp "$DIR"/agents/*.md "$HOME/.claude/agents/"
    echo "17 agents copied to ~/.claude/agents. Connect the MCP: claude mcp add --transport http coldiq https://mcp.coldiq.com/mcp" ;;
  cursor)
    mkdir -p .cursor/rules
    for f in "$DIR"/agents/*.md; do cp "$f" ".cursor/rules/$(basename "${f%.md}").mdc"; done
    [ -f .cursor/mcp.json ] || cp "$DIR/install/cursor-mcp.json" .cursor/mcp.json
    echo "17 agents written to .cursor/rules, ColdIQ MCP in .cursor/mcp.json" ;;
  codex)
    { echo "# The 17-agent SDR team"; echo; echo "When the user names an agent, follow its section below."; for f in "$DIR"/agents/*.md; do echo; sed '1,/^---$/{/^---$/!d;};/^---$/d' "$f"; done; } > AGENTS.md
    echo "AGENTS.md written. Add the MCP block of install/codex-config.toml to ~/.codex/config.toml" ;;
  *) echo "Usage: ./install.sh claude|cursor|codex"; exit 1 ;;
esac
