# Claude Code Setup — Wood Agency Network

Get Claude ready to build websites and work your GHL in under 10 minutes.

---

## Before you run setup

You need 3 things:

**1. Claude Code installed**
Download and install: https://claude.ai/download
You need a Claude Pro or Max plan ($20–$100/mo).

**2. Your GHL Private Integration Token**
- Log into GoHighLevel
- Settings → Integrations → Private Integrations
- Create new → name it "Claude MCP" → enable all scopes → copy the `pit-...` token

**3. Your GHL Location ID**
- GHL → Settings → Business Profile → scroll to Location ID
- Looks like: `MpDMPLkOAjXBtmXs5G6B`

---

## Run setup

Open Terminal (press `Cmd + Space`, type Terminal, hit Enter) and run:

```bash
curl -fsSL https://raw.githubusercontent.com/woodenman85/claude-config/main/onboarding/setup.sh | bash
```

That's it. The script will ask for your name, token, and location ID — then wire everything up automatically.

---

## After setup

1. **Restart Claude** desktop app
2. Open a new session
3. Try one of these to start:
   - *"Audit my GHL account and tell me what you see"*
   - *"Help me build a landing page for life insurance leads"*
   - *"Set up a follow-up workflow for new leads in GHL"*

---

## What gets installed

| Thing | What it does |
|-------|-------------|
| `~/.claude/CLAUDE.md` | Tells Claude who you are and how to work with you |
| GHL MCP | Direct connection to your GHL — no manual API calls |
| GHL skill | Claude knows GHL rules (never delete workflows, etc.) |
| Website skill | Claude knows how to build and deploy your site |

---

## Need help?

Contact Ben Wood — he set this up and can walk you through it.
