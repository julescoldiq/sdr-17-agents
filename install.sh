#!/usr/bin/env bash
# Installs the 17 skills in your AI tool. Usage: ./install.sh claude|cursor|codex
# Grok Build: grok plugin install <this repo URL>   Grok Bot: see README.
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
case "${1:-}" in
  claude)
    mkdir -p "$HOME/.claude/skills"
    cp -R "$DIR"/skills/* "$HOME/.claude/skills/"
    echo "17 skills copied to ~/.claude/skills. Connect the MCP: claude mcp add --transport http coldiq https://mcp.coldiq.com/mcp" ;;
  cursor)
    mkdir -p .cursor/rules
    for d in "$DIR"/skills/*/; do cp "$d/SKILL.md" ".cursor/rules/$(basename "$d").mdc"; done
    [ -f .cursor/mcp.json ] || cp "$DIR/install/cursor-mcp.json" .cursor/mcp.json
    echo "17 skills written to .cursor/rules, ColdIQ MCP in .cursor/mcp.json" ;;
  codex)
    { echo "# The 17-agent SDR team"; echo; echo "When the user names an agent, follow its section below."
      for d in "$DIR"/skills/*/; do echo; awk 'f>=2{print} /^---$/{f++}' "$d/SKILL.md"; done; } > AGENTS.md
    echo "AGENTS.md written. Add the MCP block of install/codex-config.toml to ~/.codex/config.toml" ;;
  *) echo "Usage: ./install.sh claude|cursor|codex"; exit 1 ;;
esac
