# ============================================================
# Claude Code Setup — Windows (PowerShell)
# Wood Agency Network
# Run this once after installing Claude Code desktop app
# ============================================================
# How to run:
#   irm https://raw.githubusercontent.com/woodenman85/claude-config/main/onboarding/setup.ps1 | iex

$ErrorActionPreference = "Stop"

function Write-Green  { param($msg) Write-Host "  $msg" -ForegroundColor Green }
function Write-Yellow { param($msg) Write-Host "  $msg" -ForegroundColor Yellow }
function Write-Red    { param($msg) Write-Host "  $msg" -ForegroundColor Red }
function Write-Step   { param($msg) Write-Host "`n$msg" -ForegroundColor Cyan }

Write-Host ""
Write-Host "==============================================" -ForegroundColor Cyan
Write-Host "   Claude Code Setup — Wood Agency Network"   -ForegroundColor Cyan
Write-Host "==============================================" -ForegroundColor Cyan
Write-Host ""

# ── Step 1: Collect info ──────────────────────────────────
Write-Host "We need a few things from you before we start."
Write-Host ""

$USER_NAME      = Read-Host "1. Your name (e.g. Jane Smith)"
$GHL_TOKEN      = Read-Host "2. Your GHL Private Integration Token (starts with pit-)"
$GHL_LOCATION   = Read-Host "3. Your GHL Location ID (GHL → Settings → Business Profile)"
Write-Host ""
Write-Host "4. Your 21st.dev Magic API key (free at https://21st.dev)"
Write-Host "   Sign up, go to dashboard, copy your API key."
$MAGIC_KEY      = Read-Host "   Paste it here (or press Enter to skip for now)"
Write-Host ""

# ── Step 2: Check Node.js ─────────────────────────────────
Write-Step "Checking Node.js..."
try {
    $nodeVersion = (node -v 2>$null)
    if (-not $nodeVersion) { throw }
    $nodeMajor = [int]($nodeVersion -replace 'v(\d+)\..*','$1')
    if ($nodeMajor -lt 18) {
        Write-Red "Node.js $nodeVersion is too old (need v18 or newer)."
        Write-Host "  Download the LTS version from https://nodejs.org and try again."
        exit 1
    }
    Write-Green "Node.js $nodeVersion found"
} catch {
    Write-Red "Node.js is not installed."
    Write-Host ""
    Write-Host "  Node.js is required for the MCP tools (GHL, Magic, Context7)."
    Write-Host "  Install it now:"
    Write-Host "    1. Go to https://nodejs.org"
    Write-Host "    2. Download and install the LTS version"
    Write-Host "    3. Close this window, reopen PowerShell, and run this script again"
    Write-Host ""
    exit 1
}

# ── Step 3: Check Claude is installed ────────────────────
Write-Step "Checking Claude desktop app..."
$DESKTOP_CONFIG = "$env:APPDATA\Claude\claude_desktop_config.json"

if (-not (Test-Path $DESKTOP_CONFIG)) {
    Write-Red "Claude desktop app not found."
    Write-Host "  Download and install it first: https://claude.ai/download"
    Write-Host "  (You need a Claude Pro or Max plan)"
    exit 1
}
Write-Green "Claude desktop app found"

# ── Step 4: Create ~/.claude/CLAUDE.md ───────────────────
Write-Step "Setting up your Claude config..."
$claudeDir = "$env:USERPROFILE\.claude"
New-Item -ItemType Directory -Force -Path $claudeDir | Out-Null

$claudeMd = @"
# Claude Config — $USER_NAME

## Context
I work with Wood Agency Life network — insurance products including life insurance,
mortgage protection, IUL, annuities, final expense, and debt-free life.

## GHL Account
- Location ID: ``$GHL_LOCATION``
- API token: ``$GHL_TOKEN``
- Use ``pit-*`` tokens only — never session JWTs

## Token Budget Rules
- Estimate tokens before every task; if >50k ask to split
- grep before reading whole files
- Prefer targeted reads over full-file reads

## Tool Preferences
- Browser automation: kapture first, claude-in-chrome second
- For website design: use Magic MCP for components, Context7 for accurate library docs

## What not to do
- Never delete GHL workflows — build parallel drafts instead
- Never commit tokens to git
"@

Set-Content -Path "$claudeDir\CLAUDE.md" -Value $claudeMd -Encoding UTF8
Write-Green "~/.claude/CLAUDE.md created"

# ── Step 5: Install MCPs ──────────────────────────────────
Write-Step "Installing MCP servers..."

$configJson = Get-Content -Raw -Path $DESKTOP_CONFIG | ConvertFrom-Json

if (-not $configJson.mcpServers) {
    $configJson | Add-Member -MemberType NoteProperty -Name "mcpServers" -Value ([PSCustomObject]@{})
}

# GHL — direct CRM access
$ghlServer = [PSCustomObject]@{
    command = "npx"
    args    = @("-y", "ghl-mcp-server")
    env     = [PSCustomObject]@{
        GHL_API_KEY     = $GHL_TOKEN
        GHL_BASE_URL    = "https://services.leadconnectorhq.com"
        GHL_LOCATION_ID = $GHL_LOCATION
    }
}
$configJson.mcpServers | Add-Member -MemberType NoteProperty -Name "ghl" -Value $ghlServer -Force

# Context7 — always-current framework docs
$ctx7Server = [PSCustomObject]@{
    command = "npx"
    args    = @("-y", "@upstash/context7-mcp@latest")
}
$configJson.mcpServers | Add-Member -MemberType NoteProperty -Name "context7" -Value $ctx7Server -Force

# Magic — UI components (optional)
if ($MAGIC_KEY.Trim()) {
    $magicServer = [PSCustomObject]@{
        command = "npx"
        args    = @("-y", "@21st-dev/magic@latest")
        env     = [PSCustomObject]@{ API_KEY = $MAGIC_KEY.Trim() }
    }
    $configJson.mcpServers | Add-Member -MemberType NoteProperty -Name "magic" -Value $magicServer -Force
    Write-Green "GHL, Context7, and Magic MCPs installed"
} else {
    Write-Green "GHL and Context7 MCPs installed (Magic skipped — add key later)"
}

$configJson | ConvertTo-Json -Depth 10 | Set-Content -Path $DESKTOP_CONFIG -Encoding UTF8
Write-Green "MCPs added to Claude desktop config"

# ── Step 6: Install skills ────────────────────────────────
Write-Step "Installing skills..."

$skills = @{
    "ghl" = @"
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
"@

    "design" = @"
---
name: design
description: Build beautiful, professional websites. Use when asked to create, redesign, or improve any website UI.
---

# Design Skill

## Tools available
- Magic MCP — generates polished UI components from a description
- Context7 MCP — pulls current docs for any framework
- Kapture — screenshot and inspect the live site

## Design principles for insurance agency sites
- Trust first — clean, professional, not flashy
- Mobile-first — most leads come from phones
- Clear CTAs — every page needs one obvious next step
- Fast — HTML/CSS/vanilla JS preferred

## Workflow
1. Screenshot current page with kapture
2. Identify the weakest element
3. Use Magic MCP to generate a better version
4. Preview in browser, iterate
5. Deploy via FTP when approved
"@

    "website" = @"
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
curl --ftp-pasv -T <file> ftp://<host>/domains/<domain>/public_html/<file> --user <username>:<password>

## Best practices
- Always preview before deploying
- Deploy one file at a time
- Never edit directly on the server
"@

    "gmail" = @"
---
name: gmail
description: Read, draft, and organize emails in Gmail. Use when asked to write follow-up emails, search inbox, draft outreach, or manage email threads.
---

# Gmail Skill

Use mcp__*__* Gmail tools directly.

## Insurance agency use cases
- Draft follow-up emails for leads who haven't booked yet
- Write thank-you emails after appointments
- Search inbox for unanswered lead emails
- Draft referral request emails to happy clients

## Rules
- Always draft first — never send without showing the user
- Keep emails short, warm, trust-building
- Include one clear next step
- Never promise specific rates or coverage amounts
"@

    "calendar" = @"
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
- Add client name + product to event title (e.g. Jane Smith — Life Insurance Consult)
- Set reminders 24hr and 1hr before client calls
- Never delete events without confirming with user
"@

    "canva" = @"
---
name: canva
description: Create marketing materials in Canva — social posts, flyers, lead magnets, presentations.
---

# Canva Skill

Use mcp__*__* Canva tools directly.

## Insurance agency use cases
- Social posts (Instagram, Facebook) about insurance topics
- Flyers for free consultation offers
- Lead magnets
- Client presentation slides for IUL or annuity meetings

## Rules
- Check brand kit first for consistent colors/fonts
- Always show design before finalizing
- Keep insurance marketing compliant — no guaranteed returns
"@

    "daily-briefing" = @"
---
name: daily-briefing
description: Start the day with a full business briefing. Pulls GHL pipeline, calendar, Gmail, and suggests priority actions. Use when user says good morning, start my day, what should I focus on, or daily briefing.
---

# Daily Briefing Skill

Run this every morning. Pulls live data from all connected tools and gives a prioritized action plan.

## What to pull (run all in parallel)
1. GHL — search_contacts (added last 7 days), search_opportunities (open deals by stage)
2. Calendar — list_events (today + tomorrow)
3. Gmail — search_threads (unread, last 48hrs, label:lead OR insurance)

## Output format
Good morning [name] — here's your day

PIPELINE SNAPSHOT
- X new leads this week
- X open opportunities
- Who's been sitting too long without contact (flag anyone >3 days no touch)

TODAY'S CALENDAR
- [list events with times]

INBOX NEEDS ATTENTION
- [unread threads that look like leads or need reply]

TOP 3 PRIORITIES FOR TODAY
1. [Most urgent action]
2. [Second priority]
3. [Third priority]

ONE THING
[One specific thing they should do in the next 30 minutes]

## Rules
- Keep it tight — no fluff, no filler
- Prioritize revenue actions above admin
- Always end with ONE specific action to do right now
"@

    "lead-nurture" = @"
---
name: lead-nurture
description: Build and execute lead follow-up sequences for insurance prospects. Use when asked to follow up with leads, build nurture sequences, or figure out what to say to a prospect.
---

# Lead Nurture Skill

## Lead follow-up philosophy
- Speed to lead: first contact within 5 minutes if possible
- 7-12 touches before giving up on a lead
- Mix of: call, text, email, voicemail, social
- Always lead with value, not the sell

## Follow-up sequences by product

### Life Insurance
- Day 0: Call + text
- Day 1: Email with 3 things most people don't know about life insurance
- Day 3: Call attempt 2 + voicemail
- Day 5: Text check-in
- Day 7: Email with real client story (anonymized)
- Day 10: Break-up email

### Mortgage Protection
- Lead usually has urgency — move fast
- Day 0: Call immediately + text
- Day 1: Email explaining mortgage protection in plain English

### Final Expense
- Warmer, empathetic tone
- Never be pushy — be helpful and educational
- Focus on peace of mind for family
"@

    "compliance" = @"
---
name: compliance
description: Review insurance marketing content for compliance issues before publishing or sending. Use when asked to check emails, social posts, website copy, or any client-facing content.
---

# Insurance Compliance Skill

## Hard stops (never allowed)
- Guaranteed returns or interest rates
- Guaranteed approval without qualification
- Specific benefit amounts without disclosure
- Comparing competitors by name without substantiation
- Using terms like free money or government program misleadingly
- Any claim that could be construed as misleading about policy costs

## Yellow flags (needs disclosure or rewording)
- Tax-free — needs context (loans, not withdrawals, may be tax-free)
- Specific rate illustrations — must note not guaranteed if not whole life
- Testimonials — ensure they reflect typical results or include disclaimers
- Retire early or income replacement claims — needs proper qualification

## Best practices
- Lead with education, not promises
- May, can, could instead of will for benefits
- Include results may vary near any performance claims

## How to use
1. Read through for hard stops first
2. Flag yellow items with suggested rewording
3. Provide a compliant version of the content
4. Note which state(s) the content is for (rules vary)
"@

    "sms" = @"
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
Hey [name], this is [agent] with [agency]. Saw you had questions about [product] — happy to help! When's a good time to connect?

### Follow-up after no response (Day 3)
Hey [name] — [agent] again. Just want to make sure I didn't miss you. Still happy to answer any questions about [product].

### Appointment reminder (24hr before)
Hey [name]! Quick reminder — we're chatting tomorrow at [time] about [product]. Looking forward to it! Reply if anything changes.

### After appointment (same day)
Great talking with you today [name]! I'll get that info over to you shortly. Any questions, just text or call me anytime.

### Re-engagement (cold lead, 2+ weeks)
Hey [name] — [agent] here. Wanted to check in and see if you ever got the [product] info you were looking for. No pressure, just here if you need anything!

### Referral ask
Hey [name]! Hope everything's great. If you know anyone who could use [product], I'd love to help them too. I take good care of referrals!

## GHL integration
- Use send_sms tool to send directly from GHL
- Always check contact record first for opt-in status
- Log all texts as notes in GHL contact record
"@
}

foreach ($skillName in $skills.Keys) {
    $skillDir = "$claudeDir\skills\$skillName"
    New-Item -ItemType Directory -Force -Path $skillDir | Out-Null
    Set-Content -Path "$skillDir\SKILL.md" -Value $skills[$skillName] -Encoding UTF8
    Write-Green "$skillName skill installed"
}

# ── Step 7: Git identity ──────────────────────────────────
Write-Host ""
$setGit = Read-Host "Set your git name and email? (y/n)"
if ($setGit -eq "y") {
    $gitEmail = Read-Host "Git email"
    git config --global user.name $USER_NAME
    git config --global user.email $gitEmail
    Write-Green "Git identity set"
}

# ── Done ─────────────────────────────────────────────────
Write-Host ""
Write-Host "==============================================" -ForegroundColor Green
Write-Host "   Setup complete!" -ForegroundColor Green
Write-Host "==============================================" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Close and reopen the Claude desktop app"
Write-Host "  2. Connect Gmail, Google Calendar, and Canva inside Claude:"
Write-Host "     -> Look for the integrations icon in Claude"
Write-Host "     -> Connect each app with your own account"
Write-Host "  3. Verify everything is working:"
Write-Host "     irm https://raw.githubusercontent.com/woodenman85/claude-config/main/onboarding/verify.ps1 | iex"
Write-Host ""
Write-Host "Full guide: https://github.com/woodenman85/claude-config/blob/main/onboarding/SETUP_GUIDE_WINDOWS.md"
Write-Host ""

if (-not $MAGIC_KEY.Trim()) {
    Write-Yellow "Optional: Add Magic MCP later for beautiful UI components"
    Write-Host "  1. Get a free key at https://21st.dev"
    Write-Host "  2. Open: $DESKTOP_CONFIG"
    Write-Host "  3. Add your key under the magic server's API_KEY field"
    Write-Host ""
}
