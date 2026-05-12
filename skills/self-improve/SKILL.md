---
name: self-improve
description: Audit and optimize Claude's own configuration — skills, settings.json, and context overhead. Use when the user asks to "optimize yourself", "audit your setup", or "clean up config".
---

# Self-Improvement Audit

When invoked:

1. Read `~/.claude/CLAUDE.md` (if it exists) and list all files in `~/.claude/skills/`
2. Check which skills are never referenced in recent conversations
3. Read `~/.claude/settings.json` — flag:
   - Expired or overly-specific `Bash(curl ...)` allow entries
   - Duplicate MCP tool permissions
   - Hooks firing too broadly (e.g. PostToolUse with matcher `*`)
4. Suggest concrete changes:
   - Merge redundant skills
   - Archive unused ones (move to `~/.claude/skills/_archived/`)
   - Trim verbose descriptions
   - Replace specific curl allow entries with broader patterns or remove expired ones
5. Show the user a before/after summary with estimated token savings
6. **Wait for explicit approval before making any changes**
7. After approved changes are applied, verify with `/context` if available

## Goal

Keep total context overhead under 5,000 tokens per session.

## What to measure

| Source | How to check |
|--------|-------------|
| skills/ | Count files, estimate ~200–500 tokens each |
| settings.json allow list | Count entries, flag entries >200 chars |
| MCP servers | Count active servers × ~500 tokens each |
| CLAUDE.md | Line count — flag if >150 lines |

## Safe defaults

- Never delete files — move to `_archived/` instead
- Never modify settings.json without showing diff first
- Never remove MCP servers (user must do that in app settings)
