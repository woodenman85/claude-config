# Claude Code Setup — Wood Agency Network

Get Claude ready to build beautiful websites and work your GHL in under 10 minutes.

---

## Before you run setup

You need 4 things:

**1. Claude Code installed**
Download and install: https://claude.ai/download
You need a Claude Pro or Max plan ($20–$100/mo).

**2. Your GHL Private Integration Token**
- Log into GoHighLevel
- Settings → Integrations → Private Integrations
- Create new → name it "Claude MCP" → enable all scopes → copy the `pit-...` token

**3. Your GHL Location ID**
- GHL → Settings → Business Profile → copy Location ID
- Looks like: `MpDMPLkOAjXBtmXs5G6B`

**4. A free 21st.dev Magic API key** *(for beautiful website components)*
- Go to https://21st.dev → sign up free → copy your API key
- This is what lets Claude generate professional UI components on demand
- You can skip this and add it later if you want

---

## Run setup

Open Terminal (`Cmd + Space` → type Terminal → Enter) and run:

```bash
curl -fsSL https://raw.githubusercontent.com/woodenman85/claude-config/main/onboarding/setup.sh | bash
```

The script asks for your name, tokens, and location ID — then wires everything up automatically.

---

## What gets installed

| Thing | What it does |
|-------|-------------|
| `~/.claude/CLAUDE.md` | Tells Claude who you are so every session starts smart |
| **GHL MCP** | Direct connection to your GHL — contacts, workflows, pipelines, all of it |
| **Context7 MCP** | Gives Claude current, accurate docs for any web framework |
| **Magic MCP** | Generates beautiful, production-ready UI components on demand |
| **GHL skill** | Claude knows your CRM rules (never delete workflows, etc.) |
| **Design skill** | Claude knows how to build professional insurance agency sites |
| **Website skill** | Claude knows how to deploy your site via FTP |

---

## After setup

1. **Restart Claude** desktop app
2. Open a new session and try:
   - *"Audit my GHL account and tell me what you see"*
   - *"Redesign my homepage to look more professional and trustworthy"*
   - *"Build a hero section for my life insurance website"*
   - *"Set up a follow-up workflow for new leads in GHL"*

---

## Need help?

Contact Ben Wood — he set this up and can walk you through it.
GitHub: github.com/woodenman85/claude-config
