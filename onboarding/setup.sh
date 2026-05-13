#!/bin/bash
# ============================================================
# Claude Code Setup — Websites & GoHighLevel
# Run this once after installing Claude Code desktop app
# ============================================================

set -e
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo ""
echo "=============================================="
echo "   Claude Code Setup — Wood Agency Network"
echo "=============================================="
echo ""

# ── Step 1: Collect info ──────────────────────────────────
echo "We need two things from you before we start."
echo ""
echo -n "1. Your name (e.g. Jane Smith): "
read USER_NAME

echo -n "2. Your GHL Private Integration Token (starts with pit-): "
read -s GHL_TOKEN
echo ""

echo -n "3. Your GHL Location ID (from GHL → Settings → Business Profile): "
read GHL_LOCATION_ID
echo ""

# ── Step 2: Create ~/.claude/CLAUDE.md ───────────────────
echo -e "${YELLOW}Setting up your Claude config...${NC}"

mkdir -p ~/.claude

cat > ~/.claude/CLAUDE.md << EOF
# Claude Config — $USER_NAME

## Context
I work with Wood Agency Life network — insurance products including life insurance,
mortgage protection, IUL, annuities, final expense, and debt-free life.

## GHL Account
- Location ID: \`$GHL_LOCATION_ID\`
- API token: \`$GHL_TOKEN\`
- Use \`pit-*\` tokens only — never session JWTs

## Token Budget Rules
- Estimate tokens before every task; if >50k ask to split
- grep before reading whole files
- Prefer targeted reads over full-file reads

## Tool Preferences
- Browser automation: kapture first, claude-in-chrome second
- Python available at \`python3\`

## What not to do
- Never delete GHL workflows — build parallel drafts instead
- Never commit tokens to git
EOF

echo -e "${GREEN}✓ ~/.claude/CLAUDE.md created${NC}"

# ── Step 3: Install GHL MCP ───────────────────────────────
DESKTOP_CONFIG="$HOME/Library/Application Support/Claude/claude_desktop_config.json"

if [ ! -f "$DESKTOP_CONFIG" ]; then
  echo -e "${RED}Claude desktop config not found.${NC}"
  echo "Make sure Claude Code desktop app is installed first."
  echo "Download at: https://claude.ai/download"
  exit 1
fi

# Inject GHL MCP using python3
python3 - << PYEOF
import json, os

config_path = os.path.expanduser("~/Library/Application Support/Claude/claude_desktop_config.json")
with open(config_path) as f:
    config = json.load(f)

config.setdefault("mcpServers", {})["ghl"] = {
    "command": "npx",
    "args": ["-y", "ghl-mcp-server"],
    "env": {
        "GHL_API_KEY": "$GHL_TOKEN",
        "GHL_BASE_URL": "https://services.leadconnectorhq.com",
        "GHL_LOCATION_ID": "$GHL_LOCATION_ID"
    }
}

with open(config_path, "w") as f:
    json.dump(config, f, indent=2)

print("GHL MCP wired up.")
PYEOF

echo -e "${GREEN}✓ GHL MCP added to Claude desktop config${NC}"

# ── Step 4: Install skills ────────────────────────────────
mkdir -p ~/.claude/skills/ghl
cat > ~/.claude/skills/ghl/SKILL.md << 'EOF'
---
name: ghl
description: GoHighLevel CRM work — contacts, workflows, surveys, pipelines, calendars. Use when asked to build, edit, or query anything in GHL.
---

# GoHighLevel Skill

Use mcp__ghl__* tools directly. No curl needed.

## Key rules
- Never delete workflows — build parallel drafts, user will publish/replace
- Never delete pipeline stages — suggest redesign and build alongside
- Confirm any destructive action before running
- Use pit-* tokens only, never session JWTs

## Common starting points
- Audit account: get_pipelines, ghl_get_workflows, ghl_get_surveys, get_calendars
- Find contacts: search_contacts
- Build automation: create_opportunity, add_contact_to_workflow
EOF

mkdir -p ~/.claude/skills/website
cat > ~/.claude/skills/website/SKILL.md << 'EOF'
---
name: website
description: Build, edit, and deploy websites. Use for HTML/CSS/JS edits, page creation, and pushing changes to Hostinger via FTP.
---

# Website Skill

## Workflow
1. Make edits in the local website folder
2. Preview changes with browser tools (kapture screenshot)
3. Deploy only changed files via FTP

## Deploy command template
```bash
curl --ftp-pasv -T <file> ftp://<host>/domains/<domain>/public_html/<file> \
  --user <username>:<password>
```

## Best practices
- Always preview before deploying
- Deploy one file at a time to catch errors early
- Keep a local copy in sync — never edit directly on server
EOF

echo -e "${GREEN}✓ Skills installed (ghl, website)${NC}"

# ── Step 5: Git identity ──────────────────────────────────
echo ""
echo -n "Set your git name and email? (y/n): "
read SET_GIT
if [ "$SET_GIT" = "y" ]; then
  echo -n "Git email: "
  read GIT_EMAIL
  git config --global user.name "$USER_NAME"
  git config --global user.email "$GIT_EMAIL"
  echo -e "${GREEN}✓ Git identity set${NC}"
fi

# ── Done ─────────────────────────────────────────────────
echo ""
echo "=============================================="
echo -e "${GREEN}   Setup complete!${NC}"
echo "=============================================="
echo ""
echo "Next steps:"
echo "  1. Restart the Claude desktop app"
echo "  2. Open a new session and say:"
echo "     'Audit my GHL account and tell me what you see'"
echo "  3. For websites, say:"
echo "     'Help me build/edit my website'"
echo ""
echo "Your config is saved at ~/.claude/CLAUDE.md"
echo "You can edit it anytime to add more context."
echo ""
