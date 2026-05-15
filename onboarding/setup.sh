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

# ── Step 2: Check Node.js is installed ───────────────────
if ! command -v node &> /dev/null; then
  echo -e "${RED}Node.js is not installed.${NC}"
  echo ""
  echo "Node.js is required for the MCP tools (GHL, Magic, Context7)."
  echo "Install it now:"
  echo "  1. Go to https://nodejs.org"
  echo "  2. Download and install the LTS version"
  echo "  3. Reopen Terminal and run this script again"
  echo ""
  exit 1
fi

NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
  echo -e "${RED}Node.js version is too old (found v$NODE_VERSION, need 18+).${NC}"
  echo "Download the latest LTS from https://nodejs.org and try again."
  exit 1
fi

echo -e "${GREEN}✓ Node.js $(node -v) found${NC}"

# ── Step 3: Check Claude is installed ────────────────────
DESKTOP_CONFIG="$HOME/Library/Application Support/Claude/claude_desktop_config.json"

if [ ! -f "$DESKTOP_CONFIG" ]; then
  echo -e "${RED}Claude desktop app not found.${NC}"
  echo "Download and install it first: https://claude.ai/download"
  echo "(You need a Claude Pro or Max plan)"
  exit 1
fi

# ── Step 4: Create ~/.claude/CLAUDE.md ───────────────────
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

# ── Step 5: Install MCPs ──────────────────────────────────
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

# ── Step 6: Install skills ────────────────────────────────
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

mkdir -p ~/.claude/skills/daily-briefing
cat > ~/.claude/skills/daily-briefing/SKILL.md << 'EOF'
---
name: daily-briefing
description: Start the day with a full business briefing. Pulls GHL pipeline, calendar, Gmail, and suggests priority actions. Use when user says "good morning", "start my day", "what should I focus on", or "daily briefing".
---

# Daily Briefing Skill

Run this every morning. Pulls live data from all connected tools and gives a prioritized action plan.

## What to pull (run all in parallel)

1. **GHL** — search_contacts (added last 7 days), search_opportunities (open deals by stage)
2. **Calendar** — list_events (today + tomorrow)
3. **Gmail** — search_threads (unread, last 48hrs, label:lead OR insurance)

## Output format

```
🌅 Good morning [name] — here's your day

📋 PIPELINE SNAPSHOT
- X new leads this week
- X open opportunities
- Who's been sitting too long without contact (flag anyone >3 days no touch)

📅 TODAY'S CALENDAR
- [list events with times]
- Any conflicts or back-to-backs to flag

📧 INBOX NEEDS ATTENTION
- [unread threads that look like leads or need reply]

🎯 TOP 3 PRIORITIES FOR TODAY
1. [Most urgent action]
2. [Second priority]
3. [Third priority]

💡 ONE THING
[One specific thing they should do in the next 30 minutes]
```

## Rules
- Keep it tight — no fluff, no filler
- Prioritize revenue actions (leads, appointments, follow-ups) above admin
- Flag anything that's falling through the cracks
- Always end with ONE specific action to do right now
EOF

mkdir -p ~/.claude/skills/lead-nurture
cat > ~/.claude/skills/lead-nurture/SKILL.md << 'EOF'
---
name: lead-nurture
description: Build and execute lead follow-up sequences for insurance prospects. Use when asked to follow up with leads, build nurture sequences, or figure out what to say to a prospect.
---

# Lead Nurture Skill

## Lead follow-up philosophy
- Speed to lead: first contact within 5 minutes if possible
- 7-12 touches before giving up on a lead
- Mix of: call → text → email → voicemail → social
- Always lead with value, not the sell

## Follow-up sequences by product

### Life Insurance
- Day 0: Call + text ("Hey [name], saw you were looking into life insurance — I have some quick questions that'll help me find the best fit for you. When's a good time to connect?")
- Day 1: Email with "3 things most people don't know about life insurance"
- Day 3: Call attempt 2 + voicemail
- Day 5: Text check-in
- Day 7: Email with real client story (anonymized)
- Day 10: Break-up email ("I don't want to bother you — just want to make sure you got what you needed...")

### Mortgage Protection
- Lead usually has urgency (just bought a home) — move fast
- Day 0: Call immediately + text
- Day 1: Email explaining mortgage protection in plain English
- Day 3: Follow-up call + "Did you know your lender doesn't require this but banks wish you knew about it?"

### Final Expense
- Warmer, empathetic tone — this audience has end-of-life on their mind
- Never be pushy — be helpful and educational
- Focus on peace of mind for family

## What to do with a GHL lead
1. search_contacts to find the lead
2. Check their custom fields for product interest and source
3. Look at their last activity/notes
4. Draft appropriate follow-up based on where they are in the sequence

## Prompts that work well
- "Help me follow up with a lead who filled out my life insurance form 3 days ago and hasn't responded"
- "Write a 5-touch email sequence for mortgage protection leads"
- "Draft a text to send a final expense lead who went cold"
- "What should I say on a voicemail for a life insurance prospect?"
EOF

mkdir -p ~/.claude/skills/compliance
cat > ~/.claude/skills/compliance/SKILL.md << 'EOF'
---
name: compliance
description: Review insurance marketing content for compliance issues before publishing or sending. Use when asked to check emails, social posts, website copy, or any client-facing content.
---

# Insurance Compliance Skill

## What to check for

### Hard stops (never allowed)
- ❌ Guaranteed returns or interest rates (e.g. "earn 10% guaranteed")
- ❌ Guaranteed approval without qualification
- ❌ Specific benefit amounts without disclosure
- ❌ Comparing competitors by name without substantiation
- ❌ Using terms like "free money" or "government program" misleadingly
- ❌ Implying Social Security replacement without proper context
- ❌ Any claim that could be construed as misleading about policy costs

### Yellow flags (needs disclosure or rewording)
- ⚠️ "Tax-free" — needs context (loans, not withdrawals, may be tax-free)
- ⚠️ Specific rate illustrations — must note "not guaranteed" if not whole life
- ⚠️ "Infinite banking" claims — ensure no misleading banking comparisons
- ⚠️ Testimonials — ensure they reflect typical results or include disclaimers
- ⚠️ "Retire early" or income replacement claims — needs proper qualification

### Best practices
- ✅ Lead with education, not promises
- ✅ "May", "can", "could" instead of "will" for benefits
- ✅ Include "results may vary" near any performance claims
- ✅ State licensing disclosure when required by state law

## How to use
When reviewing content:
1. Read through for hard stops first
2. Flag yellow items with suggested rewording
3. Provide a compliant version of the content
4. Note which state(s) the content is for (rules vary)
EOF

mkdir -p ~/.claude/skills/sms
cat > ~/.claude/skills/sms/SKILL.md << 'EOF'
---
name: sms
description: Draft text messages to leads and clients — follow-ups, appointment reminders, check-ins. Use when asked to write a text, SMS, or quick message to a prospect or client.
---

# SMS Skill

## The rules of insurance texting
- Keep it under 160 characters when possible
- Sound human — not like a bot
- One clear ask per text
- Never include policy details or rates in a text
- Always identify yourself by name on first text
- Check state TCPA rules — get opt-in consent before texting

## Text templates by situation

### First contact after form fill
```
Hey [name], this is [agent] with [agency]. Saw you had questions about [product] — happy to help! When's a good time to connect? 📞
```

### Follow-up after no response (Day 3)
```
Hey [name] — [agent] again. Just want to make sure I didn't miss you. Still happy to answer any questions about [product]. 🙂
```

### Appointment reminder (24hr before)
```
Hey [name]! Quick reminder — we're chatting tomorrow at [time] about [product]. Looking forward to it! Reply if anything changes.
```

### After appointment (same day)
```
Great talking with you today [name]! I'll get that info over to you shortly. Any questions, just text or call me anytime.
```

### Re-engagement (cold lead, 2+ weeks)
```
Hey [name] — [agent] here. Wanted to check in and see if you ever got the [product] info you were looking for. No pressure, just here if you need anything!
```

### Referral ask
```
Hey [name]! Hope everything's great. If you know anyone who could use [product], I'd love to help them too. I take good care of referrals! 🙏
```

## GHL integration
- Use send_sms tool to send directly from GHL
- Always check contact record first for opt-in status
- Log all texts as notes in GHL contact record
EOF

echo -e "${GREEN}✓ Skills installed (ghl, design, website, daily-briefing, lead-nurture, compliance, sms)${NC}"

# ── Step 7: Git identity ──────────────────────────────────
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
