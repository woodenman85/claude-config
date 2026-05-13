# Step-by-Step Setup Guide
### Claude Code for Wood Agency Network

Don't worry if you've never done anything like this before. Follow each step exactly and you'll be done in about 10 minutes.

---

## Step 1 — Install Claude Code

1. Go to **https://claude.ai/download** on your Mac
2. Download and install the app (it looks like a normal Mac app install)
3. Open Claude and sign in — you need a **Claude Pro plan** ($20/mo)
   - If you don't have one: click your name → Upgrade to Pro

✅ **You're done with Step 1 when:** Claude opens and you can chat with it.

---

## Step 2 — Get your GHL Private Integration Token

This gives Claude permission to work inside your GoHighLevel account.

1. Log into **GoHighLevel**
2. Click **Settings** (bottom left gear icon)
3. Click **Integrations**
4. Click **Private Integrations**
5. Click **+ Create New Integration**
6. Name it: `Claude MCP`
7. **Enable ALL scopes** (turn everything on — this lets Claude do the most for you)
8. Click **Save** or **Create**
9. Copy the token that appears — it starts with `pit-` and looks like:
   `pit-f7f643ce-f370-485a-87a3-c30edafa0a17`

> ⚠️ **Save this somewhere safe** — you'll need it in Step 5. Don't share it publicly.

✅ **You're done with Step 2 when:** You have a `pit-...` token copied.

---

## Step 3 — Get your GHL Location ID

1. Still in GoHighLevel, go to **Settings**
2. Click **Business Profile** (sometimes called Company Info)
3. Look for **Location ID** — it's a string of letters and numbers like:
   `MpDMPLkOAjXBtmXs5G6B`
4. Copy it

✅ **You're done with Step 3 when:** You have your Location ID copied.

---

## Step 4 — Get your free Magic API key

This is what makes Claude build beautiful, professional-looking websites (not ugly AI output).

1. Go to **https://21st.dev**
2. Click **Sign Up** — it's free
3. Once logged in, go to your **Dashboard**
4. Find your **API Key** and copy it

> You can skip this for now and add it later, but your website designs will look much better with it.

✅ **You're done with Step 4 when:** You have an API key from 21st.dev (or you're skipping for now).

---

## Step 5 — Run the setup

Now you'll run a single command that sets everything up automatically.

### How to open Terminal on a Mac:
1. Press **Cmd + Space** (the Command key and the Space bar at the same time)
2. Type `Terminal`
3. Press **Enter**
4. A black or white window opens — that's Terminal

### Run this command:
Copy this entire line, paste it into Terminal, and press **Enter**:

```
curl -fsSL https://raw.githubusercontent.com/woodenman85/claude-config/main/onboarding/setup.sh | bash
```

> **How to paste in Terminal:** Cmd + V (same as everywhere else on a Mac)

### The script will ask you for:
- Your name
- Your GHL `pit-...` token (from Step 2)
- Your GHL Location ID (from Step 3)
- Your 21st.dev API key (from Step 4) — press Enter to skip if you don't have it yet

Just type or paste each one and press **Enter**.

✅ **You're done with Step 5 when:** You see "Setup complete!" in green.

---

## Step 6 — Restart Claude

1. Quit Claude completely: **Cmd + Q**
2. Open Claude again
3. Start a new conversation

✅ **You're done!** Claude is now set up for you.

---

## Try these to get started

Copy and paste any of these into Claude:

**For your website:**
> "Look at my current website and tell me what you'd improve to get more insurance leads."

> "Build me a hero section for my life insurance website. Make it professional, trustworthy, and include a button to book a free consultation."

> "Redesign my homepage. I sell life insurance, mortgage protection, and final expense insurance. Mobile-first, clean, modern."

**For GoHighLevel:**
> "Audit my GHL account and tell me what you see — pipelines, workflows, contacts."

> "Help me set up an automated follow-up sequence for new leads in GHL."

> "Show me all my current workflows and tell me which ones might need improvement."

---

## Something didn't work?

**"Command not found" error in Terminal**
→ Make sure you copied the entire command including the `curl` at the beginning.

**"Claude desktop app not found" error**
→ Make sure Claude is installed from claude.ai/download before running setup.

**The script didn't ask for my Magic API key**
→ That's fine — it's optional. You can add it later.

**Anything else**
→ Contact Ben Wood — he can walk you through it.

---

## What got installed

After setup, here's what Claude now knows and can do:

| What | Does |
|------|------|
| Your identity | Claude knows you work in the Wood Agency network and what products you sell |
| **GHL connection** | Claude can read and edit your GoHighLevel directly — no copy-pasting |
| **Design tools** | Claude can generate beautiful website sections using professional UI patterns |
| **Framework docs** | Claude always uses current, correct code — no broken or outdated stuff |
| **GHL rules** | Claude will never delete your workflows — it builds new ones alongside instead |

---

*Setup created by Ben Wood · github.com/woodenman85/claude-config*
