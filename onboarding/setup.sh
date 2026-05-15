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
echo "We need a few things from you before we start."
echo ""
echo -n "1. Your name (e.g. Jane Smith): "
read USER_NAME

echo -n "2. Your GHL Private Integration Token (starts with pit-): "
read -s GHL_TOKEN
echo ""

echo -n "3. Your GHL Location ID (GHL → Settings → Business Profile): "
read GHL_LOCATION_ID
echo ""

echo "4. Your 21st.dev Magic API key (free at https://21st.dev)"
echo "   Sign up, go to dashboard, copy your API key."
echo -n "   Paste it here (or press Enter to skip for now): "
read MAGIC_KEY
echo ""

# ── Step 2: Check Claude is installed ────────────────────
DESKTOP_CONFIG="$HOME/Library/Application Support/Claude/claude_desktop_config.json"

if [ ! -f "$DESKTOP_CONFIG" ]; then
  echo -e "${RED}Claude desktop app not found.${NC}"
  echo "Download and install it first: https://claude.ai/download"
  echo "(You need a Claude Pro or Max plan)"
  exit 1
fi

# ── Step 3: Create ~/.claude/CLAUDE.md ───────────────────
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
- For website design: use Magic MCP for components, Context7 for accurate library docs
- Python available at \`python3\`

## What not to do
- Never delete GHL workflows — build parallel drafts instead
- Never commit tokens to git
EOF

echo -e "${GREEN}✓ ~/.claude/CLAUDE.md created${NC}"

# ── Step 4: Install MCPs ──────────────────────────────────
echo -e "${YELLOW}Installing MCP servers...${NC}"

python3 - << PYEOF
import json, os, sys

config_path = os.path.expanduser("~/Library/Application Support/Claude/claude_desktop_config.json")
with open(config_path) as f:
    config = json.load(f)

servers = config.setdefault("mcpServers", {})

# GHL — direct CRM access
servers["ghl"] = {
    "command": "npx",
    "args": ["-y", "ghl-mcp-server"],
    "env": {
        "GHL_API_KEY": "$GHL_TOKEN",
        "GHL_BASE_URL": "https://services.leadconnectorhq.com",
        "GHL_LOCATION_ID": "$GHL_LOCATION_ID"
    }
}

# Context7 — always-current framework docs (no key needed)
servers["context7"] = {
    "command": "npx",
    "args": ["-y", "@upstash/context7-mcp@latest"]
}

# Magic — beautiful UI components (optional, needs API key)
magic_key = "$MAGIC_KEY".strip()
if magic_key:
    servers["magic"] = {
        "command": "npx",
        "args": ["-y", "@21st-dev/magic@latest"],
        "env": { "API_KEY": magic_key }
    }
    print("✓ GHL, Context7, and Magic MCPs installed")
else:
    print("✓ GHL and Context7 MCPs installed (Magic skipped — add key later)")

with open(config_path, "w") as f:
    json.dump(config, f, indent=2)
PYEOF

echo -e "${GREEN}✓ MCPs added to Claude desktop config${NC}"

# ── Step 5: Install skills ────────────────────────────────
echo -e "${YELLOW}Installing skills...${NC}"

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

mkdir -p ~/.claude/skills/design
cat > ~/.claude/skills/design/SKILL.md << 'EOF'
---
name: design
description: Build beautiful, professional websites. Use when asked to create, redesign, or improve any website UI — landing pages, sections, components, or full sites.
---

# Design Skill

## Tools available
- **Magic MCP** — generates polished UI components from a description. Use: `/magic create a [component] for [context]`
- **Context7 MCP** — pulls current docs for any framework so code is always accurate. Add `use context7` to any prompt using a library.
- **Kapture** — screenshot and inspect the live site to see what needs improving

## Design principles for insurance agency sites
- Trust first — clean, professional, not flashy
- Mobile-first — most leads come from phones
- Clear CTAs — every page needs one obvious next step (book a call, get a quote)
- Fast — HTML/CSS/vanilla JS preferred, no heavy frameworks unless needed

## Workflow
1. Screenshot current page with kapture
2. Identify the weakest element (hero, CTA, trust signals, layout)
3. Use Magic MCP to generate a better version
4. Preview in browser, iterate
5. Deploy via FTP when approved

## Prompts that work well with Magic
- "Create a hero section for a life insurance agency with a CTA to book a call"
- "Build a product card for mortgage protection insurance with key benefits"
- "Design a testimonial section — clean, modern, mobile-friendly"
- "Create a sticky nav bar for an insurance agency website"
EOF

mkdir -p ~/.claude/skills/gmail
cat > ~/.claude/skills/gmail/SKILL.md << 'EOF'
---
name: gmail
description: Read, draft, and organize emails in Gmail. Use when asked to write follow-up emails, search inbox, draft outreach, or manage email threads for leads and clients.
---

# Gmail Skill

Use mcp__*__* Gmail tools directly.

## Insurance agency use cases
- Draft follow-up emails for leads who haven't booked yet
- Write thank-you emails after appointments
- Search inbox for unanswered lead emails
- Draft referral request emails to happy clients
- Write cold outreach for mortgage protection or final expense

## Rules
- Always draft first — never send without showing the user
- Keep emails short, warm, trust-building
- Include one clear next step (book a call, reply with questions)
- Never promise specific rates or coverage amounts
EOF

mkdir -p ~/.claude/skills/calendar
cat > ~/.claude/skills/calendar/SKILL.md << 'EOF'
---
name: calendar
description: Manage Google Calendar — schedule appointments, check availability, set reminders for client calls and follow-ups.
---

# Calendar Skill

Use mcp__*__* Calendar tools directly.

## Insurance agency use cases
- Schedule client consultation calls
- Block prospecting time
- Add follow-up reminders for leads
- Check weekly schedule before booking

## Rules
- Always confirm date/time before creating events
- Add client name + product to event title (e.g. "Jane Smith — Life Insurance Consult")
- Set reminders 24hr and 1hr before client calls
- Never delete events without confirming with user
EOF

mkdir -p ~/.claude/skills/canva
cat > ~/.claude/skills/canva/SKILL.md << 'EOF'
---
name: canva
description: Create marketing materials in Canva — social posts, flyers, lead magnets, presentations. Use when asked to design anything for marketing or client outreach.
---

# Canva Skill

Use mcp__*__* Canva tools directly.

## Insurance agency use cases
- Social posts (Instagram, Facebook) about insurance topics
- Flyers for free consultation offers
- Lead magnets (e.g. "5 Things to Know Before Buying Life Insurance")
- Client presentation slides for IUL or annuity meetings
- Referral cards, business cards, email headers

## Rules
- Check brand kit first for consistent colors/fonts
- Always show design before finalizing
- Keep insurance marketing compliant — no guaranteed returns, no misleading claims
- Square format for Instagram, landscape for Facebook/email
EOF

mkdir -p ~/.claude/skills/website
cat > ~/.claude/skills/website/SKILL.md << 'EOF'
---
name: website
description: Edit and deploy websites via FTP. Use for HTML/CSS/JS edits and pushing changes live.
---

# Website Skill

## Workflow
1. Make edits in the local website folder
2. Preview with kapture screenshot
3. Deploy only changed files via FTP

## Deploy template
```bash
curl --ftp-pasv -T <file> ftp://<host>/domains/<domain>/public_html/<file> \
  --user <username>:<password>
```

## Best practices
- Always preview before deploying
- Deploy one file at a time
- Never edit directly on the server
EOF

echo -e "${GREEN}✓ Skills installed (ghl, design, website)${NC}"

# ── Step 6: Git identity ──────────────────────────────────
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
echo "  1. Restart the Claude desktop app (Cmd+Q then reopen)"
echo "  2. Connect Gmail, Google Calendar, and Canva inside Claude:"
echo "     → Look for the integrations/plugins icon in Claude"
echo "     → Connect each app with your own account (takes ~1 min each)"
echo "  3. Read the full guide for prompts to get started:"
echo "     https://github.com/woodenman85/claude-config/blob/main/onboarding/SETUP_GUIDE.md"
echo ""

if [ -z "$MAGIC_KEY" ]; then
  echo -e "${YELLOW}Optional: Add Magic MCP later for beautiful UI components${NC}"
  echo "  1. Get a free key at https://21st.dev"
  echo "  2. Open: ~/Library/Application Support/Claude/claude_desktop_config.json"
  echo "  3. Replace REPLACE_WITH_YOUR_21ST_DEV_KEY with your key"
  echo ""
fi

echo "Your config: ~/.claude/CLAUDE.md"
echo ""
